var voices = [];

function setVoiceList() {
    voices = window.speechSynthesis.getVoices();
}

setVoiceList();

if(window.speechSynthesis.onvoiceschanged !== undefined) {
    window.speechSynthesis.onvoiceschanged = setVoiceList;
}

var button = document.getElementById("speech-button");
var select = document.getElementById("speech-language");



function speech(text) {
    if(!window.speechSynthesis) {
        alert("음성 재생을 지원하지 않는 브라우저입니다.");
        return;
    }

    var lang = select.options[select.selectedIndex].value;

    var utterThis = new SpeechSynthesisUtterance(text);

    utterThis.onend = function(event) {
        console.log("end");
    }

    utterThis.onerror = function(event) {
        console.log("error", event); 
    }

    var voiceFound = false;
    
    // console.log(voices[i].voiceURI);
    
    switch(lang) {
        case "en-US":
            voiceFound = true;
            utterThis.voice = voices[6];
            break;
        case "ja-JP":
            utterThis.voice = voices[8];
            voiceFound = true;
            break;
            
        case "ko-KR":
            utterThis.voice = voices[4];
            voiceFound = true;
            break;
    }

    if(!voiceFound) {
        alert("voice not found");
        return;
    }

    
    utterThis.lang = lang;
    utterThis.pitch = 1;
    utterThis.rate = 1;
    window.speechSynthesis.speak(utterThis);
    console.log(voices);
}


button.addEventListener("click", function(){
    var text= document.getElementById("speech-word").value;
    speech(text);
})

