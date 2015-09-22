var gitolite_instance = null;

function Init(path) {
    gitolite_instance = new Gitolite();
    gitolite_instance.path = path;
}

function GetUsersNames() {
    if (gitolite_instance == null) {
        console.log("Error: gitolite_instance is null");
        return null;
    }

    var fs = require('fs');
    var path = require('path');

    console.log("Read names from " + gitolite_instance.path);

    var files = fs.readdirSync(gitolite_instance.path);//, function (error, files) {
    var error = null;
        if (error == null) {

            var list = [];

            for (var idx = 0; idx < files.length; idx++) {
                var file_name = files[idx];
                if (!file_name.endsWith(".pub")) {
                    continue;
                } else {
                    list.push(path.basename(file_name, '.pub'));
                }
            }
             
            console.log("Before returning: " + list);
            return list;
        }
        else {
            console.error("Fuck, can't read directory");
        }
        
        return null;
    //});
}

function Gitolite() {
    this.path = "";
}

module.exports.GetUsersNames = GetUsersNames;
module.exports.Init = Init;
