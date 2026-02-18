const sign_up = document.getElementById('sign_up');
const log_in = document.getElementById('log_in');



sign_up.addEventListener('submit', async (e) =>{
     e.preventDefault();
    const formData = new FormData(sign_up);
    const password = formData.get('pwd');
    const confirmPassword = formData.get('cpwd');
    const errormessage = document.querySelector('.error');

    if (password === confirmPassword) {
        try
    {
        const response = await fetch('bridge.php?action=sign_up', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();
        if(result.success === true)
        {  
            window.location.href = "index.html";
        }
        else{
            errormessage.textContent = "Please refresh and try again later.";
        }

    }
    catch (error) {
        console.error("Error connecting: ", error);
    }

    } else {
        sign_up.reset();
        errormessage.textContent = "Passwords do not match.";
            }
    

    
});

log_in.addEventListener('submit', async (e) =>{
     e.preventDefault();

    const formData = new FormData(log_in);
    const password = formData.get('pwd');
    const errormessage = document.querySelector('.errorL');

    
    try
    {
        const response = await fetch('bridge.php?action=log_in', {
            method: 'POST',
            body: formData
        });
        const result = await response.json();

        if(result.success === true)
        {  
            window.location.href = "home_page.html";
        }
        else(result.success === false)
        {   
            errormessage.textContent = result.message;
            log_in.reset();    
        }
    }
    catch (error) {
        console.error("Error connecting: ", error);
    }
});