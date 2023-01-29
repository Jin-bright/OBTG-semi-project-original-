// endpoint 웹소켓접속이 처음 이루어지는 url 
const ws = new WebSocket(`ws://${location.host}/OBTG/websocket`);

ws.addEventListener('open', (e) => {
	console.log('open : ', e);
});
ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	
	const {message, messageType, datetime, sender, receiver} = JSON.parse(e.data);
	console.log(message, messageType, datetime, sender, receiver);
	
	switch(messageType){
		case "NOTIFICATION" : 
			const i = document.createElement("i");
			i.classList.add('fa-solid', 'fa-bell', 'bell');
			i.addEventListener('click', () => {
				alert(message);
				i.remove();
			});
			notification.append(i);
			break;
	}
	

});
ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});
ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});