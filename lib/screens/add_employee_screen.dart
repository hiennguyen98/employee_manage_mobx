import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_emp_manager/stores/employee_store.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({key}) : super(key: key);
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  EmployeeStore _employeeStore;
  @override
  void initState() {
    _employeeStore = Provider.of<EmployeeStore>(context, listen: false);
    _employeeStore.setupValidations();
    _employeeStore.initNewEmployee();
    super.initState();

  }

  @override
  void dispose() {
    // _employeeStore.dispose();
    super.dispose();
  }

  /// handle add new employee
  _addNewEmployee() {
    // if( _employeeStore != null && _employeeStore.canAddEmp){
    //
    // }
    _employeeStore.insertEmpLocal();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => _employeeStore.setNameEmp(value),
                  decoration: InputDecoration(
                      labelText: 'Full name(*)',
                      hintText: 'Pick a full name',
                      errorText: _employeeStore.error.name),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _employeeStore.age = int.parse(value) ,
                  decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Pick an age',),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => _employeeStore.position = value,
                  decoration: InputDecoration(
                      labelText: 'Position',
                      hintText: 'Pick a position',
                    ),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => _employeeStore.phone = value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Phone (*)',
                      hintText: 'Pick a phone',
                      errorText: _employeeStore.error.phone),
                ),
              ),
              Observer(
                builder: (_) => TextField(
                  onChanged: (value) => _employeeStore.address = (value),
                  decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Pick an address',
                      ),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.blue,
                child: Text("ADD", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white
                ),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: _addNewEmployee,
              ),
            ],
          ),
        ),

      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('Add An Employee', style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),),
      brightness: Brightness.light,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
