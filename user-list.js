function UserList() {
    this.users                = [];
    this.LoadUsers            = LoadUsers;
    this.AddElement           = AddElement;
    this.element              = users_list;
    this.selectedName         = null;
    this.SelectUser           = SelectUser;
    this.DeselectUser         = DeselectUser;
    this.GetElementByUserName = GetElementByUserName;
}

function SelectUser(userName) {
    var index = this.users.indexOf(userName);
    if (index == -1)
        return;

    // Deselect current name.
    if (this.selectedName != null) {
        this.DeselectUser(this.selectedName);
    }

    this.selectedName = userName;
    var el = this.GetElementByUserName(userName);
    el.classList.add('selected');
}

function DeselectUser(user_name) {
    var element = this.GetElementByUserName(user_name);
    element.classList.remove("selected");
}

function GetElementByUserName(user_name) {
    var childs = this.element.childNodes;
    for( var i=0; i < childs.length; i++) {
        if(childs[i].innerHTML == user_name) {
            return childs[i];
        }
    }
    return null;
}

function LoadUsers () { 
    var gitolite = require('./gitolite');
    gitolite.Init("E:/Unity/gitolite-admin/keydir");
    this.users = gitolite.GetUsersNames();
    console.log(this.users);

    var u = this;
    this.users.forEach(function(el) {
        u.AddElement(el);
    });
    console.log("LoadUsers");
}

function AddElement(text) {
    var el = document.createElement("ul");
    var user_list = this;
    //el.className.Add('user_name');
    el.innerHTML = text;
    el.onclick = function(e) {
        user_list.SelectUser(this.innerHTML);
        console.log("Selected user: " + this.innerHTML);
    };
    this.element.appendChild(el);
}

module.exports = UserList;
