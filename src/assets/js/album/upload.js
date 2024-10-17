const fileInput = document.querySelector('#upload input');
const selectedFiles = document.getElementById('selectedFiles');
const form = document.getElementById('upload');
const uploadList = document.getElementById('uploadList');


form.addEventListener('submit', (event) => {
    event.preventDefault();

    uploadFiles();
})

function uploadFiles() {
    for (file of fileInput.files) {
        console.log(file);
        uploadFile(file);
    }

    //document.location = form.getAttribute('action');
}

function uploadFile(file) {
    const card = document.createElement('div');
    const cardContent = document.createElement('div');
    const progressBar = document.createElement('progress');

    card.classList = 'card';
    cardContent.classList = 'card-content';
    //cardContent.innerText = file.name;
    progressBar.classList = 'progress';
    progressBar.setAttribute('value',  0);
    progressBar.setAttribute('max', file.size);
    cardContent.appendChild(progressBar);
    card.appendChild(cardContent);

    uploadList.insertBefore(card, uploadList.firstChild);

    const formdata = new FormData();
    const request = new XMLHttpRequest();

    formdata.append('file', file);

    request.upload.addEventListener('progress', (e) => {
        progressBar.setAttribute('value', e.loaded);

        // if(e.loaded == e.total){
        //     $('#progress-bar-file1').width(100 + '%').html(100 + '%');
        // } else if (e.loaded <= file.size) {
        //     var percent = Math.round(e.loaded / file.size * 100);
        //     $('#progress-bar-file1').width(percent + '%').html(percent + '%');
        // }
    });

    request.onerror = (event) => {
        
    };

    request.onload = event => {
        if (request.status != 200) {
            progressBar.classList += ' is-danger';
        }
    }

    request.open('post', document.location);
    request.timeout = 45000;
    request.send(formdata);
}


fileInput.onchange = () => {
  if (fileInput.files.length > 0) {
    //const fileName = document.querySelector("#file-js-example .file-name");
    //fileName.textContent = fileInput.files[0].name;
    //fileList.replaceChildren();
    
    for (file of fileInput.files) {
        console.log(file)

        // const card = document.createElement('div');
        // const cardContent = document.createElement('div');
// 
        // card.classList = 'card';
        // cardContent.classList = 'card-content';
        // cardContent.innerText = file.name;
        // card.appendChild(cardContent);
// 
        // fileList.appendChild(card);
    }

    selectedFiles.querySelector('span').innerText = `Selected ${fileInput.files.length} files for upload.`
    selectedFiles.removeAttribute('hidden');
  }


};