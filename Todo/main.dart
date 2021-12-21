import 'dart:io';
//id listteki index mi olmaslı yoksa unique olarak ben mi oluşturmalıyım?


void main(List<String> args) {
  interface();
}

void interface(){
  while(true){
    print("ToDo List\n");
    List<Task> uncompletedtasks = TodoList.todolist.where((task) => task.isCompleted == false ).toList();
    
    if(uncompletedtasks.isNotEmpty){
      print("name - when - description");
      for(var i =0;i<uncompletedtasks.length;i++){
        Task element = TodoList.todolist[i];
        print("${i+1}- ${element._name}  ${element._when.toString().substring(0,16)}  ${element._description}");
      }
    }

    else{
      print("you don't have any tasks");
    }


    print("\npress N for create new task");
    if(uncompletedtasks.isNotEmpty){
      print("press F for finish a task");
    }
    print("press C for close program");

    String? action = stdin.readLineSync();

    if(action == "N"){
      print("Enter task name");
      String? taskname = stdin.readLineSync().toString();
      if(taskname.length<3){
        throw Exception("task name length can't be shorter than 3");
      }

      print("Enter descirption  (it is optional)");
      String? descirption = stdin.readLineSync().toString();

      print("Enter to do date    (example : 0000-00-00 00:00)");
      DateTime? when = DateTime.parse(stdin.readLineSync().toString());

      print("Enter location");
      String? location = stdin.readLineSync().toString();
      
      TodoList.createTask(name: taskname, description: descirption , when: when, where: location);
    }

    else if(action == "F"){
      if(uncompletedtasks.isNotEmpty){
        print("Enter task number");
        int number = int.parse(stdin.readLineSync().toString());

        if(number < uncompletedtasks.length +1 && number > 0){
          int index = uncompletedtasks[number-1]._indexInTheList;
          TodoList.setTaskIsCompleted(index);
          
        } else {
          print("select a valid number");
        }

      }
      else{
        print("select a valid transaction");
      }
    }
    else if(action == "C"){
      break;
    }
    else{
      print("select a valid transaction");
    }


  }
}





class TodoList{
  static List<Task> todolist = [];

  static setTaskIsCompleted(int i){
    todolist[i].setisCompleted(true);
  }

  static createTask({required String name,String description="",required DateTime when,required String where}){
    if(when.isBefore(DateTime.now())){
      throw Exception("when cant be in past");
    }else{
      int lenghtoftodolist = todolist.length;
      Task newtask = Task(name, description, when, where,lenghtoftodolist);
      todolist.add(newtask);  
    }
  }
}

class Task{
  String _name = "";  
  String _description = ""; 
  DateTime _when = DateTime.parse("0000-00-00"); 
  String _where = ""; 
  int _indexInTheList = -1;

  DateTime _creationDate = DateTime.parse("0000-00-00"); 
  String _id = ""; 

  DateTime _executionDate = DateTime.parse("0000-00-00");
  bool _isCompleted = false;


  void setisCompleted(bool isCompleted){
    if(isCompleted == false){

    }else{
      this._isCompleted = isCompleted;
      _setExecutionDate();      
    }
  }


  Task(String _name,String _description,DateTime _when,String _where,int _indexInTheList){
    this._name = _name;
    this._description = _description;
    this._when = _when;
    this._where = _where;
    this._indexInTheList = _indexInTheList;
    
    _setCurrenttime();
    _createidUniqueId();
  }


  _createidUniqueId(){
    this._id = this._name +" "+ (this._creationDate).toString();
  }
  _setCurrenttime(){

    this._creationDate = DateTime.now();
  }
  _setExecutionDate(){
    this._executionDate = DateTime.now();
  }

  
  //getters
  String get name => _name;
  String get description => _description;
  DateTime get when => _when;
  String get where => _where;
  int get indexInTheList => _indexInTheList;

  DateTime get creationDate => _creationDate;
  String get id => _id;

  DateTime get executionDate => _executionDate;
  bool get isCompleted => _isCompleted;
}