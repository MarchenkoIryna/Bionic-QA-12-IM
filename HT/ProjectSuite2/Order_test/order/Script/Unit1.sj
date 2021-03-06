function Main()
{   
// preparation
   TestedApps.Orders.Run();
   var file =  Files.FileNameByName("data_order.txt");
   Log.Message("creating driving");
   var driver = DDT.CSVDriver(file);
   var i=1;//order's number
   
// add orders
   while(!driver.EOF())
   { 
   var Customer=driver.Value(0);
   var Street=driver.Value(1);
   var State=driver.Value(2);
   var City=driver.Value(3);  
   var Zip=driver.Value(4); 
   var CardNo=driver.Value(5);    
   New_Order(i, Customer, Street, State, City, Zip, CardNo);
   i++;
   driver.Next();
   }
   DDT.CloseDriver(file);

//delete orders
   while (Aliases.Sys.Orders.MainForm.OrdersView.FocusedItem)
   {
   Aliases.Sys.Orders.MainForm.OrdersView.FocusedItem.Remove();
   }
   Log.Message("All orders have been deleted");
   
//cleanup
  Log.AppendFolder("Application is closed"); 
  Aliases.Sys.Orders.MainForm.Close();
  Aliases.Sys.Orders.dlgConfirmation.btnNo.ClickButton(); 
}
   
function New_Order(i, Customer, Street, State, City, Zip, CardNo)
{
  Log.AppendFolder("order # " + i+ " is added and checked");   
 // fill the form 
  Aliases.Sys.Orders.MainForm.MainMenu.Click("Orders|New order...");
  Aliases.Sys.Orders.OrderForm.Group.Customer.wText = Customer;
  Aliases.Sys.Orders.OrderForm.Group.Street.wText = Street;
  Delay(1000);
  Aliases.Sys.Orders.OrderForm.Group.City.wText = City;
  Aliases.Sys.Orders.OrderForm.Group.State.wText = State;
  Aliases.Sys.Orders.OrderForm.Group.Zip.wText = Zip;
  Aliases.Sys.Orders.OrderForm.Group.CardNo.wText = CardNo;
  Aliases.Sys.Orders.OrderForm.ButtonOK.ClickButton();
  //check the Customer name in MainForm
  if (aqObject.CompareProperty(Aliases.Sys.Orders.MainForm.OrdersView.wSelectedItems, 0, Customer, false))
      Log.Message("OK");
    else
      Log.Error("The property value does not equal the baseline value.");
    Log.PopLogFolder();

  }
    