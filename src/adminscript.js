async function loadMusic() {
    const container = document.getElementById('preview');
    try {
        const response = await fetch('bridge.php?action=get_all_songs');
        const songs = await response.json();
        const searchBar = `
            <div>
                <form class="searchbar">
                    <input class="search" placeholder="search" name="music">
                    <input class="searchbtn" type="submit" value="search">
                </form>
            </div>
                
        `;

        const songList = songs.map(song => `
            <div class="song-card"
                data-src="${song.preview_url}"
                data-title="${song.title}"
                data-artist="${song.artist_name}"
                data-cover="${song.cover_url}"
                style="display:flex; gap:15px; padding:10px; cursor:pointer; height:6vh;">

                <img src="${song.cover_url}" width="50" height="50"
                     style="border-radius:4px; object-fit:cover;">

                <div style="text-align:left; flex-grow:1;">
                    <h3 style="margin:0; font-size:1rem;">${song.title}</h3>
                    <p style="margin:0; font-size:0.8rem; opacity:0.8;">
                        ${song.artist_name}
                    </p>
                </div>
                <div class="action-btns">
                   <button onclick="removeSong('${song._id}')">Remove</button>
                </div>
                
                
            </div>
        `).join('');

        container.innerHTML = searchBar + songList;
    } catch (error) {
        console.error("Error loading songs:", error);
    }
}

window.addEventListener("DOMContentLoaded", loadMusic);

async function removeSong(songId) {

    if (!songId || songId === 'undefined') {
        console.error("Error: Song ID is missing.");
        return;
    }
    if (!confirm("Are you sure you want to delete this song?")) return;

    try {
        const response = await fetch(`bridge.php?action=delete_song&id=${songId}`, {
            method: 'GET' 
        });
        
        const result = await response.json();

        if (result.success) {
            loadMusic();
        }
    } catch (error) {
        console.error("Delete failed:", error);
    }
}



async function loadUsers() {
    const container = document.getElementById('preview');
    try {
        const response = await fetch('bridge.php?action=users');
        const users = await response.json();
        const headBar = `
            <h2 style = "text-align:center";> Users </h2>
            <table>
                <tr>
                    <th>Id</th>
                    <th>First Name</th> 
                    <th>Last Name</th> 
                    <th>User Name</th> 
                    <th>email</th>     
                    <th>phone</th> 
                    <th>created</th>
                    <th>action</th>
                </tr>
        `;

        const UserList = users.map(user => `
            <tr>
                <td>${user.id}</td>
                <td>${user.first_name}</td> 
                <td>${user.last_name}</td> 
                <td>${user.username}</td> 
                <td>${user.email}</td>     
                <td>${user.phone}</td> 
                <td>${user.created_at}</td>
                <td class="action-btns">
                    <button class="restriction" data-userid="${user.id}" value="Restrict">Restrict</button>
                </td>
            </tr>
        `).join('');
        const tableEnd = `</table>`;


        container.innerHTML = headBar + UserList + tableEnd;

    } catch (error) {
        console.error("Error loading users:", error);
    }
}


document.getElementById('preview').addEventListener( 'click', async function(event){
    
    const btn = event.target.closest('.restriction');
    
    if (!btn) return;

    const userId = btn.dataset.userid;
    const currentActn = btn.value;

    btn.disabled = true;
    try {
        const formData = new FormData();
        formData.append('user', userId);
        formData.append('actn', currentActn);

        const response = await fetch('bridge.php?action=restr', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();

        if (result.success == true) {
            if (currentActn === "Restrict") {
                btn.textContent = "Release";
                btn.value = "Release";
            } else {
                btn.textContent = "Restrict";
                btn.value = "Restrict";
            }
        } else {
            console.error("operation failed", result.message);
        }
    } catch (error) {
        console.error("connection: ", error);
    }
    finally {
        btn.disabled = false;
    }
});
   



async function Searched_songs(){
    const container = document.getElementById('preview');
    try {
        const response = await fetch('bridge.php?action=get_searched_songs');
        const songs = await response.json();
        const songList = songs.map(song => `
            <div class="song-card"style="display:flex; gap:15px; padding:10px; cursor:pointer; height:6vh;">
                <div style="text-align:left; flex-grow:1;">
                    <h3 style="margin:0; font-size:1rem;">${song.title}</h3>
                    <p style="margin:0; font-size:0.8rem; opacity:0.8;">
                        ${song.artist}
                    </p>
                </div>
                <div class="action-btns">
                   <button onclick="add_music('${song.title}','${song.artist}')">add</button>
                </div>     
            </div>
        `).join('');

        container.innerHTML = songList;
    } catch (error) {
        console.error("Error loading songs:", error);
    }
}

async function add_music(title, artist) {
    const container = document.getElementById('preview');

    try {
        const formData = new FormData();
        formData.append('title', title);
        formData.append('artist', artist);

        const response = await fetch('bridge.php?action=sync_single', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();

        if (result.status === "success") {
            container.innerHTML = `<h2 style="color:green;">${result.message}</h2>`;
            setTimeout(loadMusic, 2000);
        } else {
            showManualForm(title, artist);
        }
    } catch (error) {
        console.error("Error:", error);
        showManualForm(title, artist);
    }
}

function showManualForm(title, artist) {
    const container = document.getElementById('preview');
    container.innerHTML = `
        <div class="manual-entry">
            <h3>Song not found automatically. Please enter details:</h3>
            <h1 id="result"></h1>
            <form id="manualInsertForm">
                <label>Music Title</label>
                <input type="text" name="title" value="${title}" required>
                
                <label>Artist</label>
                <input type="text" name="artist" value="${artist}" required>
                
                <label>Album</label>
                <input type="text" name="album" placeholder="Album Name">
                
                <label>Preview URL (.mp3 link)</label>
                <input type="text" name="preview_url"  required>
                
                <label>Cover URL (Image link)</label>
                <input type="text" name="cover_url">
                
                <input type="submit" value="Add" class="add">
            </form>
        </div>
    `;

    document.getElementById('manualInsertForm').onsubmit = async (e) => {
        e.preventDefault();
        const manualData = new FormData(e.target);
        
        const resp = await fetch('bridge.php?action=manual_add', {
            method: 'POST',
            body: manualData
        });
        const res = await resp.json();
        if(res.status) {
            const result = document.getElementById('result')
            result.textContent = res.message;
            loadMusic();
        }
    };
}

document.getElementById('syncbtn').addEventListener('click', async function() {
    const btn = this;
    const container = document.getElementById('preview');

    btn.disabled = true;
    container.innerHTML= `
            <h1>Fetching data from APIs...</h1>
        `;

    try {
        const response = await fetch('loader.php?action=sync');
        const result = await response.json();

        if (result.status === "success") {
            container.innerHTML= `
            <h1>${result.message}</h1>
            <p>Last Sync: Just now</p>
            `;
             
        }
    } catch (error) {
        console.error("Sync Error:", error);
        alert("Sync failed. Check console for details.");
    } finally {
        btn.disabled = false;
    }
});
























































