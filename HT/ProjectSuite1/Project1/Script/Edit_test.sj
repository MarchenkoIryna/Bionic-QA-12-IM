//Check the editing *.txt files in Notepad
function Main()
{      
//parametres
       var sPath ="c:\\Documents and Settings\\All Users\\Desktop\\TestFile.txt";
       var text = "Hello ";      
//create new .txt file  
       Log.AppendFolder("create new file"); 
       file_new(sPath, text);
       Log.PopLogFolder();
//modify file
       Log.AppendFolder("file editing"); 
       modify (sPath, text);
       Log.PopLogFolder(); 
//delete file  
       aqFileSystem.DeleteFile(sPath);
       Log.Message("File " + sPath + " is deleted");    
}
//open file
 function file_open (file_name)
 {
  TestedApps.notepad.Run();
  var wndNotepad = Aliases.Sys.notepad.Window("Notepad");
  wndNotepad.MainMenu.Click("File|Open...");
  Aliases.Sys.notepad.Window("#32770", "Open").OpenFile(file_name);  
  Log.Message("File "+ file_name+ " is opened");     
 }
 
//create new file, add text and check that text has been added
 function file_new(file_name, text)   
{ 
  if (!aqFile.Exists(file_name))
  var myFile = aqFile.Create(file_name);
  aqFile.WriteToTextFile(file_name, text, aqFile.ctANSI, false);
  Log.Message("New file "+ file_name+ " is created"); 
  file_open(file_name);  
//check the text field 
  aqObject.CompareProperty(Aliases.Sys.notepad.wndNotepad.Edit.wText, cmpEqual, text);  
  TestedApps.notepad.Close(); 
}

//open existed file, modify it, save changes and check that changes has been saved
  function modify(file_name, text)
  {
  file_open(file_name);
  // Obtain the edit object
  var Edit =  Aliases.Sys.notepad.Window("Notepad").Window("Edit");
  Edit.Keys(text); 
  Log.Message("New text " + text + " added");   
  
  Aliases.Sys.notepad.wndNotepad.MainMenu.Click("File|Save");    
  TestedApps.notepad.Close(); 
  file_open(file_name);
  aqObject.CompareProperty(Aliases.Sys.notepad.wndNotepad.Edit.wText, cmpEqual, text+text);          
  TestedApps.notepad.Close();  
  }