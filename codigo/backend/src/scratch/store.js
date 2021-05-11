//import module
// constructor function to create a storage directory inside our project for all our localStorage setItem.
if (typeof localStorage === "undefined" || localStorage === null) {
    var LocalStorage = require('node-localstorage').LocalStorage;
    localStorage = new LocalStorage('./scratch');
  }

functions = {
    setEmail: function setEmail(email){
        localStorage.setItem('email',email)
    },
    getEmail: function getEmail(callback){
         return callback(localStorage.getItem('email'))
    },delete: function (){
        localStorage.removeItem('email')
        localStorage.removeItem('nameAuction')
        localStorage.removeItem('date')
        localStorage.removeItem('description')
        localStorage.removeItem('items')
    }, setDataEmail : (nameAuction, description, date)=>{
        localStorage.setItem('nameAuction',nameAuction)
        localStorage.setItem('description',description)
        localStorage.setItem('date',date)
    }, getAuctionData : (callback) => {
        
    }
}

module.exports = functions
