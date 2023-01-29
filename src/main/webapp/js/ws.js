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
			bell.classList.remove('bell-hiden');
			bell.classList.add('bell-twinkle');
			bell.addEventListener('click', () => {
				reportWrap.insertAdjacentHTML('beforeend', `<div class="report">${message}</div>`);
				
				const report = document.querySelectorAll(".report");
				report.forEach((r) => {
					r.addEventListener('click', () => {
						r.remove();
					});
				});
				
			});
			document.notiUpdateFrm.submit();
			break;
	}
});
ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});
ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});

document.notiUpdateFrm.addEventListener("submit", (e) => {
	e.preventDefault(); // 폼제출 방지
	
	const frmData = new FormData(e.target);
	console.log(frmData);
	
	$.ajax({
		url : "<%= request.getContextPath() %>/notification/notificationUpdate",
		dataType : "json",
		method : "POST",
		data : frmData,
		success(data){
			console.log(data);
			const bell = document.querySelector(".bell");
			bell.classList.remove('bell-twinkle');
			bell.classList.add('bell-hiden');
		},
		error : console.log
	});	
});
