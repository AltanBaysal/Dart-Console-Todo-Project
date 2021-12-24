import 'dart:io';

void main(List<String> args) {
  Interface.start();
  
}

class Interface{
  static start(){
    bool whileworking = true;
    while(whileworking){
      printTodoTable();
      printActionOptionsAN();
      whileworking = takeAction();
    }
    print("the program has been closed successfully");
  }


  static printTodoTable(){
    print("                                                ToDo List\n");
    if(TodoList.uncompletedtasks.isNotEmpty){
      print("name - when - description");
      printTasks(TodoList.uncompletedtasks);
    }
    else{
      print("you don't have any tasks");
    }
  }

  static printTasks(List<Task> tasks){
    for(var i =0;i< tasks.length;i++){
      Task element = tasks[i];
      print("${i+1}- ${element.name}  ${element.when.toString().substring(0,16)}  ${element.description}");
    }
  }


  static printActionOptionsAN(){
    print("\npress N for create new task");
    if(TodoList.uncompletedtasks.isNotEmpty) print("press F for finish a task");
    print("press C for close program");
}


  static bool takeAction(){
    String? action = stdin.readLineSync();

    switch(action!.toUpperCase()){
      case "N":{
        ActionN();
      } break;
        
      case "F":{
        ActionF();
      } break;

      case "C":{
        return false;
      }

      default:{
        print("select a valid transaction");
      } break;
    }

    return true;
  }

  static ActionN(){
    print("Enter task name");
    String? taskname = stdin.readLineSync().toString();
    if(taskname.length < 3) throw Exception("task name length can't be shorter than 3");

    print("Enter descirption  (it is optional)");
    String? descirption = stdin.readLineSync().toString();

    print("Enter to do date    (example : 0000-00-00 00:00)");
    DateTime? when = DateTime.parse(stdin.readLineSync().toString());
    if(when == null) throw Exception("enter current date");

    print("Enter location");
    String? location = stdin.readLineSync().toString();
      
    TodoList.createTask(name: taskname, description: descirption , when: when, where: location);
    print("Task has created Successfully");
  }

  static ActionF(){
    if(TodoList.uncompletedtasks.isNotEmpty){
      print("Enter task number");
      int number = int.parse(stdin.readLineSync().toString());

      if(number < TodoList.uncompletedtasks.length+1 && number >0){
        int index = TodoList.uncompletedtasks[number-1].indexInTheList;
        TodoList.setTaskIsCompleted(index);
      }

      else{
        print("select a valid number");
      }

    }
    else{
      print("select a valid transaction");
    }

  }
}

class TodoList{
  static List<Task> _todolist = [];
  static List<Task> _uncompletedtasks = [];

  static setTaskIsCompleted(int i){
    todolist[i].setisCompleted(true);
    _setUncompletedTasks();
  }

  static createTask({required String name,String description="",required DateTime when,required String where}){
    if(when.isBefore(DateTime.now())){
      throw Exception("when cant be in past");
    }else{
      int lenghtoftodolist = todolist.length;
      Task newtask = Task(name, description, when, where,lenghtoftodolist);
      todolist.add(newtask);  
      _setUncompletedTasks();
    }
  }

  //private func
  static _setUncompletedTasks(){
    _uncompletedtasks = TodoList.todolist.where((task) => task.isCompleted == false ).toList();
  }

  //getters
  static List<Task> get todolist => _todolist;
  static List<Task> get uncompletedtasks => _uncompletedtasks;
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

