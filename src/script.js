let currentAudio = new Audio();
let isPlaying = false;
const searchForm = document.querySelector('.searchbar');
let song_src = [];
const prev_song = new Map();
let Current_index= 0;

async function loadMusic() {
    const container = document.getElementById('music-preview');
    try {
        const response = await fetch('bridge.php?action=get_all_songs');
        const songs = await response.json();

        for (const item of songs) {
            song_src.push(item.preview_url);
        }
        container.innerHTML = songs.map(song => `
            <div class="song-card" 
                 data-src="${song.preview_url}" 
                 data-title="${song.title}" 
                 data-artist="${song.artist_name}" 
                 data-cover="${song.cover_url}">

                <img src="${song.cover_url}" class="cover" alt="Album Art" width="100">
                <h3 class="title">${song.title}</h3>
                <p class="artist">${song.artist_name}</p>
            </div>
        `).join('');
        
        setupPlayerControls();
    } catch (error) {
        console.error("Error loading songs:", error);
    }
}


searchForm.addEventListener('submit', async (e) => {
    e.preventDefault(); 
    
    const formData = new FormData(searchForm);
    const container = document.getElementById('music-preview');

    try {
        const response = await fetch('bridge.php?action=searchM', {
            method: 'POST',
            body: formData
        });
        const songs = await response.json();

        if (songs.length === 0) {
            const message = `
            <div>
            <h2 style='color: white; padding: 20px;'>No songs found.</h2>`;
            const formm = `
            <form class="add_music" action="bridge.php?action=requestedM" method="post">
                <input type="text" required placeholder="Music Title" name="title">
                <input type="text" required placeholder="artist" name="artist">
                <input type="submit" value="Request">
            </form>
            </div>
            `
            container.innerHTML = message + formm;

            return;
        }

        container.innerHTML = songs.map(song => `
            <div class="song-card" 
                data-src="${song.preview_url}" 
                data-title="${song.title}" 
                data-artist="${song.artist_name}" 
                data-cover="${song.cover_url}"
                style="display: flex; gap: 15px; padding: 10px; cursor: pointer; height: 6vh;">
                
                <img src="${song.cover_url}" class="cover" alt="Album Art" width="50" height="50" style="border-radius: 4px; object-fit: cover;">
                
                <div class="song-info" style="text-align: left; flex-grow: 1;">
                    <h3 class="title" style="margin: 0; font-size: 1rem;">${song.title}</h3>
                    <p class="artist" style="margin: 0; font-size: 0.8rem; opacity: 0.8;">${song.artist_name}</p>
                </div>
            </div>
        `).join('');

       setupPlayerControls()
        
    } catch (error) {
        console.error("Search failed:", error);
    }
});


function setupPlayerControls() {
    const cards = document.querySelectorAll('.song-card');
    const playBtn = document.querySelector('.play');
    const pauseBtn = document.querySelector('.pause');

    cards.forEach(card => {
        card.addEventListener("click", () => {
            const src = card.getAttribute('data-src');
            
            document.getElementById("p_cover").innerHTML = `<img src="${card.getAttribute('data-cover')}" width="100%" height="100%">`;
            document.getElementById("p_title").textContent = card.getAttribute('data-title');
            document.getElementById("p_artist").textContent = card.getAttribute('data-artist');

            currentAudio.src = src;
            playSong();
            window.scrollTo({
                top: 0,
                behavior: 'smooth' 
            });
        });
    });

    playBtn.addEventListener('click', playSong);
    pauseBtn.addEventListener('click', pauseSong);
}

document.querySelector('.prev').addEventListener('click', (e) => {
    currentAudio.src = song_src[(Current_index-1)];
    playSong();
    Current_index -= 1;
    window.scrollTo({
                top: 0,
                behavior: 'smooth' 
            });
});

document.querySelector('.next').addEventListener('click', (e) => {
    currentAudio.src = song_src[Current_index];
    playSong();
    prev_song.set(Current_index, currentAudio.src);
    Current_index += 1;
    window.scrollTo({
                top: 0,
                behavior: 'smooth' 
            });
});

function playSong() {
    if(!currentAudio.src) return;
    currentAudio.play();
    isPlaying = true;
    document.querySelector('.play').style.display = 'none';
    document.querySelector('.pause').style.display = 'block';
}

function pauseSong() {
    currentAudio.pause();
    isPlaying = false;
    document.querySelector('.play').style.display = 'block';
    document.querySelector('.pause').style.display = 'none';
}

currentAudio.addEventListener('timeupdate', () => {
    if (!isNaN(currentAudio.duration)) {
    const progress = (currentAudio.currentTime / currentAudio.duration) * 100;
    document.querySelector('.runner').style.left = `${progress}%`;
    const tracker = document.querySelector('.tracker');
    tracker.style.setProperty('--progress', `${progress}%`);
    }
});

currentAudio.addEventListener('ended', () => {
    
    document.querySelector('.play').style.display = 'block';
    document.querySelector('.pause').style.display = 'none';
    
    document.querySelector('.runner').style.left = `0%`;
    document.querySelector('.tracker').style.setProperty('--progress', `0%`);
});

async function toggleplaylist()
{
    const playlist = document.querySelector('.playlist');
    playlist.classList.toggle('active');

}


document.getElementById('music-preview').addEventListener('submit', async (e) => {
   
    if (e.target.classList.contains('add_music')) {
        e.preventDefault(); 
        
        const form = e.target;
        const formData = new FormData(form);
        const container = document.getElementById('music-preview');

        try {
           
            const response = await fetch('bridge.php?action=requestedM', {
                method: 'POST',
                body: formData
            });
            const result = await response.json();
            
            if (result.success) {
                container.innerHTML = `<h2 style='color: #010101; padding: 20px;'>Song Requested Successfully!</h2>`;
            }
        } catch (error) {
            console.error("Error requesting song:", error);
        }
    }
});

document.getElementById('acc_page').addEventListener('click', (e) =>{

    window.location.href = "account.html";
    users_data();
});

window.addEventListener("DOMContentLoaded", loadMusic);