// endpoint 웹소켓접속이 처음 이루어지는 url 
const ws = new WebSocket(`ws://${location.host}/OBTG/websocket`);

ws.addEventListener('open', (e) => {
	console.log('open : ', e);
});
ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	const bell = document.querySelector(".bell");
	const reportWrap = document.querySelector("#report_wrap");
	
	const {message, messageType, datetime, sender, receiver} = JSON.parse(e.data);
	console.log(message, messageType, datetime, sender, receiver);
	
	switch(messageType){
		case "NOTIFICATION" : 
			bell.classList.add('bell-twinkle');
			bell.addEventListener('click', () => {
				reportWrap.insertAdjacentHTML('beforeend', `<div class="report">${message}</div>`);
				
				const r = document.querySelectorAll(".report");
				r.forEach((a) => {
					a.addEventListener('click', () => {
					a.remove();
					})
				});
				//alert(message);
				bell.classList.remove('bell');
			});
			break;
	}
	

});
ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});
ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});