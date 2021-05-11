const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');
const btnAddItem = document.getElementById('btnAddItem')
const btnTeste = document.getElementById('btnTeste')

signUpButton.addEventListener('click', () => {
	console.log('entrei')
	container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
	console.log('entre aqui 2')
	container.classList.remove("right-panel-active");
});

btnTeste.addEventListener('click', ()=>{
	console.log('teste deu certo')
})