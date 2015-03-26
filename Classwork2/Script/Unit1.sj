function Main()
{

    TestedApps.calc.Run();  
   var file =  Files.FileNameByName("data.txt");
   Log.Message("creating driving");
   var driver = DDT.CSVDriver(file);
   while (!driver.EOF())
   {
   var input1=driver.Value(0);
   var sign=driver.Value(1);
   var input2=driver.Value(2);
   var expected=driver.Value(3);   
   
   Test_operation(input1, sign, input2, expected);
   
   driver.Next();
   }
   DDT.CloseDriver(file);

    TestedApps.calc.Close(); 
} 
     
     function Test_operation(input1, sign, input2,expected)
{
Log.AppendFolder("test of operation " + sign);
  var wndCalculator = Aliases.wndCalculator;
  
 //perform operation
  wndCalculator.Window("Button",input1).Click();
  wndCalculator.Window("Button",sign).Click();
  wndCalculator.Window("Button",input2).Click();
  wndCalculator.Window("Button","=").Click();
 
  //check expected and actual result
  aqObject.CompareProperty(Aliases.Edit.wText, cmpEqual, expected + ". ");
  Log.PopLogFolder();
  
}

/*function Test_Sum()
{
 //run calc;
  TestedApps.calc.Run();  
  var wndCalculator = Aliases.wndCalculator;
  
 //perform operation
  wndCalculator.Window("Button","4").Click();
  wndCalculator.Window("Button","+").Click();
  wndCalculator.Window("Button","6").Click();
  wndCalculator.Window("Button","=").Click();
 
  //check expected and actual result
  aqObject.CompareProperty(Aliases.wndCalculator.Edit.wText, cmpEqual, "10. ", false);
  
  //close calc
  wndCalculator.Close();
}

function test_mapping()
{
       Sys.Process("calc").Window("SciCalc", "Calculator", 1).Window("Button", "8", 9).Click();
       NameMapping.Sys.calc.wndCalculator.btn8.Click();
       Aliases.btn8.Click();
       var b8= Aliases.btn8;
       b8.Click();
}   */


