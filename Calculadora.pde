/*Panel panel;

void setup() {
  size(320,420);
  panel = newPanel();
  
  panel.add(
    newVBox().gap(1).position(10,30).dimension(width-4,60)
     .add(newLabel("0").fontSize(70).strokeColor(255))
     .add(newLabel("Display: ").fontSize(10))
   );
   
  panel.add(
    newVBox().gap(1).position(2,90).dimension(width-4,height-92)
    .add(newHBox().gap(1)
      .add(newButton("C").labelSize(24))
      .add(newButton("±").labelSize(24))
      .add(newButton("%").labelSize(24))
      .add(newButton("÷").labelSize(24))
    )
    .add(newHBox().gap(1)
      .add(newButton("7").labelSize(24))
      .add(newButton("8").labelSize(24))
      .add(newButton("9").labelSize(24))
      .add(newButton("x").labelSize(24))
    )
    .add(newHBox().gap(1)
      .add(newButton("4").labelSize(24))
      .add(newButton("5").labelSize(24))
      .add(newButton("6").labelSize(24))
      .add(newButton("-").labelSize(24))
    )
    .add(newHBox().gap(1)
      .add(newButton("1").labelSize(24))
      .add(newButton("2").labelSize(24))
      .add(newButton("3").labelSize(24))
      .add(newButton("+").labelSize(24))
    )
    .add(newHBox().gap(1)
      .add(newHBox().gap(1)
        .add(newButton("0").labelSize(24))
      )
      .add(newHBox().gap(1)
        .add(newButton(",").labelSize(24))
        .add(newButton("=").labelSize(24))
      )
    )
  );

  panel.update();
}

void draw() {
  background(color(110,129,135));
  panel.draw();
}

void mouseClicked() {
  panel.pick(mouseX,mouseY,null,null);
}

void keyPressed() {
  panel.keyStroke(key,keyCode,null);
}*/

Panel panel;
Label label;
double ans,v1;
String OP = "";

void setup() {
size(320,420);
  panel = newPanel();
  
  panel.add(
    newVBox().gap(1).position(0,0).size(width-4,90)
     .add(label = (Label)newLabel("0").id("label").fontSize(70).fontColor(255))
   );
   
  panel.add(
    newVBox().gap(1).position(0,90).size(width,height-90)
    .add(newHBox().gap(1)
      .add((newButton("C",200).value("C")).id("SP").fontSize(24))
      .add((newButton("±",200).value("+-")).id("SP").fontSize(24))
      .add((newButton("%",200).value("%")).id("SP").fontSize(24))
      .add((newButton("÷", color(255,157,60)).value("÷")).id("OP").fontColor(255).fontSize(34))
    )
    .add(newHBox().gap(1)
      .add((newButton("7").value("7")).id("NUM").fontSize(24))
      .add((newButton("8").value("8")).id("NUM").fontSize(24))
      .add((newButton("9").value("9")).id("NUM").fontSize(24))
      .add((newButton("x", color(255,157,60)).value("x")).id("OP").fontColor(255).fontSize(34))
    )
    .add(newHBox().gap(1)
      .add((newButton("4").value("4")).id("NUM").fontSize(24))
      .add((newButton("5").value("5")).id("NUM").fontSize(24))
      .add((newButton("6").value("6")).id("NUM").fontSize(24))
      .add((newButton("-", color(255,157,60)).value("-")).id("OP").fontColor(255).fontSize(34))
    )
    .add(newHBox().gap(1)
      .add((newButton("1").value("1")).id("NUM").fontSize(24))
      .add((newButton("2").value("2")).id("NUM").fontSize(24))
      .add((newButton("3").value("3")).id("NUM").fontSize(24))
      .add((newButton("+", color(255,157,60)).value("+")).id("OP").fontColor(255).fontSize(34))
    )
    .add(newHBox().gap(1)
      .add(newHBox().gap(1)
        .add((newButton("0").value("0")).id("NUM").fontSize(24))
      )
      .add(newHBox().gap(1)
        .add(newButton(",").fontSize(24))
        .add((newButton("=", color(255,157,60)).value("=")).id("EQ").fontColor(255).fontSize(34))
      )
    )
  );

  panel.update();
}

void draw() {
  background(color(110,129,135));
  panel.draw();
}

void mousePressed() {
  panel.mouseDown(mouseX,mouseY,new Click());
}

void mouseReleased() {
  panel.mouseUp(mouseX,mouseY,null);
}

void keyPressed() {
  panel.keyStroke(key,keyCode,null);
}

class Click extends Action {
  void run(Graphic g) {
    java.text.DecimalFormat df = new java.text.DecimalFormat("0.#######");
    Control c = (Control)g;
    if (c.id()=="NUM"){
      if(OP != ""){
        label.setValue("0");
        OP="";
      }
      double x = Double.parseDouble(label.getValue());
      double y = Double.parseDouble(c.value());
      if(x>=0)label.setValue(df.format(x*10+y));
      else label.setValue(df.format((x*10)-y));
      panel.update();
    }
    if (c.id()=="SP"){
      double x = Double.parseDouble(label.getValue());
      if(c.value()=="C"){
        label.setValue("0");
        OP="";
        v1 = ans = 0;//podria utilizar solo un valor auxiliar
      }
      if(c.value()=="+-"){
        label.setValue(df.format(x*-1));
      }
      if(c.value()=="%"){
        ans=x/100;
        label.setValue(df.format(ans));
        OP = "%";
      }
      panel.update();
    }
    if (c.id()=="OP"){
      double x = Double.parseDouble(label.getValue());
      OP=c.value();
      v1=x;
      
      panel.update();
    }
    if (c.id()=="EQ"){
      double x = Double.parseDouble(label.getValue());
      if(OP=="%")ans=x/100;
      if(OP=="-")ans=v1-x;
      if(OP=="+")ans=v1+x;
      if(OP=="÷")ans=v1/x;
      if(OP=="x")ans=v1*x;
      label.setValue(df.format(ans));
      v1=0;
      panel.update();
    }
  }
}