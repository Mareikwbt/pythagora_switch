import fisica.*;
FWorld world;
FBox[][] gearbox=new FBox [4][6];
FBox[] domino;
FBox[] domino2;
FBlob circle1=new FBlob();
FCircle wheel1, wheel2, cir;
FPoly trolley, hook;
FBox box14, box15, box16, box17, box26, box27, box28, box29;
FDistanceJoint rotahook;
FPoly fin;
int angle;
void setup()
{
  size(1024, 576);
  Fisica.init(this);
  world = new FWorld();
  world.setEdges();
  world.setGravity(0, 1000);

  FBox[] leftrect=new FBox[6];
  for (int i=0; i<5; i++)
  {
    leftrect[i]=new FBox(150, 5);
    leftrect[i].setNoStroke();
    leftrect[i].setFill(0);
    leftrect[i].setStatic(true);
    if (i%2==0)
    {
      leftrect[i].setPosition(100, 100+50*(i+1));
      leftrect[i].setRotation(radians(10));
    } else
    {
      leftrect[i].setPosition(200, 100+50*(i+1));
      leftrect[i].setRotation(radians(-10));
    }
    world.add(leftrect[i]);
  }

  FCircle [] gear=new FCircle [4];
  FCircle[] center=new FCircle[4];
  for (int i=0; i<2; i++)
  {
    center[i]=new FCircle(1);
    center[i].setPosition(200+80*i, 400);
    center[i].setStatic(true);
    world.add(center[i]);
    gear [i]=new FCircle (60) ;
    gear [i]. setPosition (200+80*i, 400) ;
    gear [i]. setStatic (true) ;
    gear[i].setNoStroke();
    gear [i]. setFill (0) ;
    world. add (gear [i]) ;
    for (int j=0; j<4; j++)
    {
      gearbox[i][j]=new FBox (85, 8) ;
      if (i%2==0)
      {
        gearbox[i][j]. setPosition(200+80*i+cos(radians(45*j)), 400+sin(radians(45*j))) ;
        gearbox[i][j]. setRotation (radians (45*j)) ;
      } else
      {
        gearbox[i][j].setPosition(200+80*i+cos(radians(15+45* j)), 400+sin(radians(15+45*j)));
        gearbox[i][j]. setRotation (radians (15+45*j)) ;
      }
      gearbox[i][j].setStatic(true);
      gearbox[i][j].setNoStroke();
      gearbox [i][j]. setFill(0) ;
      world. add(gearbox [i][j]) ;
    }
  }

  FBox box11=new FBox(110, 5);
  box11.setPosition(255, 470);
  box11.setRotation(radians(-10));
  box11.setFill(0);
  box11.setStatic(true);
  world.add(box11);

  FCircle mid=new FCircle(6);
  mid.setPosition(42.5+120, 484);
  mid.setNoFill();
  mid.setNoStroke();
  mid.setStatic(true);
  world.add(mid);

  domino=new FBox[9];
  for (int i=0; i<9; i++)
  {
    domino[i]=new FBox(3, 30);
    domino[i].setPosition(42.5+15*i, 483);
    domino[i].setFill(0);
    domino[i].setDensity(50.0);
    world.add(domino[i]);
  }

  FDistanceJoint[] junta=new FDistanceJoint[1];
  junta[0]=new FDistanceJoint(domino[8], mid);
  junta[0].setAnchor1(0, 15);
  junta[0].setAnchor2(0, 15);
  junta[0].setNoFill();
  junta[0].setNoStroke();
  world.add(junta[0]);


  FBox box12=new FBox(130, 2);
  box12.setPosition(100, 500);
  box12.setFill(0);
  box12.setStatic(true);
  world.add(box12);

  FCircle mid2=new FCircle(2);
  mid2.setPosition(30, 500);
  mid2.setStatic(true);
  mid2.setNoFill();
  mid2.setNoStroke();
  world.add(mid2);

  FBox box13=new FBox(5, 100);
  box13.setPosition(30, 500);
  box13.setFill(0);
  world.add(box13);

  FDistanceJoint mid2_1=new FDistanceJoint(mid2, box13);
  mid2_1.setAnchor1(0, 0);
  mid2_1.setAnchor2(0, 0);
  world.add(mid2_1);

  domino2=new FBox[8];
  for (int i=0; i<8; i++)
  {
    domino2[i]=new FBox(3, 50);
    domino2[i].setPosition(45.5+15*i, 545);
    domino2[i].setFill(0);
    domino2[i].setDensity(50.0);
    world.add(domino2[i]);
  }

  wheel1=new FCircle(12);
  wheel1.setPosition(170, 562);
  wheel1.setFill(0);
  wheel1.setFriction(0);
  world.add(wheel1);
  wheel2=new FCircle(12);
  wheel2.setPosition(200, 562);
  wheel2.setFill(0);
  wheel2.setFriction(0);
  world.add(wheel2);

  trolley=new FPoly();
  trolley.setFill(0);
  trolley.vertex(155, 525);
  trolley.vertex(155, 560);
  trolley.vertex(215, 560);
  trolley.vertex(215, 525);
  trolley.vertex(210, 525);
  trolley.vertex(210, 555);
  trolley.vertex(160, 555);
  trolley.vertex(160, 525);
  trolley.setRestitution(0.0);
  world.add(trolley);

  FDistanceJoint joint1=new FDistanceJoint(trolley, wheel1);
  pushMatrix();
  joint1.setAnchor1(170, 565);
  joint1.setAnchor2(0, 0);
  joint1.setLength(0);
  world.add(joint1);
  FDistanceJoint joint2=new FDistanceJoint(trolley, wheel2);
  joint2.setAnchor1(200, 565);
  joint2.setAnchor2(0, 0);
  joint2.setLength(0);
  world.add(joint2);

  box14=new FBox(10, 10);
  box14.setPosition(375, 570);
  box14.setNoFill();
  box14.setNoStroke();
  box14.setStatic(true);
  world.add(box14);

  FBox tunnel1=new FBox(5, 550);
  tunnel1.setPosition(350, 225);
  tunnel1.setFill(0);
  tunnel1.setStatic(true);
  world.add(tunnel1);
  FBox tunnel2=new FBox(5, 550);
  tunnel2.setPosition(400, 351);
  tunnel2.setFill(0);
  tunnel2.setStatic(true);
  world.add(tunnel2);

  FCircle midbox15=new FCircle(1);
  midbox15.setPosition(400, 76);
  midbox15.setStatic(true);
  world.add(midbox15);

  box15=new FBox(100, 5);
  box15.setPosition(400, 76);
  box15.setFill(0);
  box15.setNoStroke();
  world.add(box15);

  FDistanceJoint rota15=new FDistanceJoint(midbox15, box15);
  rota15.setAnchor1(0, 0);
  rota15.setAnchor2(0, 0);
  world.add(rota15);

  FCircle midhook=new FCircle(5);
  midhook.setPosition(447, 22.5);
  midhook.setStatic(true);
  world.add(midhook);

  hook=new FPoly();
  hook.setFill(0);
  hook.vertex(420, 20);
  hook.vertex(420-50/2, 20+50/2*sqrt(3));
  hook.vertex(425-50/2+5/sqrt(2), 20+50/2*sqrt(3)+5/sqrt(2));
  hook.vertex(425, 25);
  hook.vertex(485, 25);
  hook.vertex(485, 40);
  hook.vertex(490, 40);
  hook.vertex(490, 20);
  hook.setStatic(true);
  world.add(hook);

  rotahook=new FDistanceJoint(hook, midhook);
  rotahook.setAnchor1(447, 22.5);
  rotahook.setAnchor2(0, 0);
  rotahook.setLength(0);
  world.add(rotahook);

  box16=new FBox(450, 5);
  box16.setPosition(650, 80);
  box16.setRotation(radians(5));
  box16.setFill(0);
  box16.setStatic(true);
  world.add(box16);

  cir=new FCircle(30);
  cir.setFill(240, 96, 96);
  cir.setPosition(465, 35);
  world.add(cir);

  FBox box17=new FBox(5, 40);
  box17.setPosition(930, 200);
  box17.setFill(0);
  box17.setStatic(true);
  box17.setRestitution(3.0);
  box17.setRotation(radians(30));
  world.add(box17);

  FBox box18=new FBox(40, 5);
  box18.setPosition(540, 200);
  box18.setFill(0);
  box18.setStatic(true);
  box18.setRestitution(3.0);
  box18.setRotation(radians(60));
  world.add(box18);

  FBox box19=new FBox(40, 5);
  box19.setPosition(650, 130);
  box19.setFill(0);
  box19.setStatic(true);
  box19.setRestitution(0.5);
  box19.setRotation(radians(20));
  world.add(box19);

  FBox box20=new FBox(40, 5);
  box20.setPosition(750, 350);
  box20.setFill(0);
  box20.setStatic(true);
  box20.setRestitution(0.5);
  box20.setRotation(radians(-20));
  world.add(box20);

  FBox box21=new FBox(40, 5);
  box21.setPosition(540, 350);
  box21.setFill(0);
  box21.setStatic(true);
  box21.setRestitution(1.0);
  box21.setRotation(radians(-20));
  world.add(box21);

  FBox box22=new FBox(40, 5);
  box22.setPosition(450, 300);
  box22.setFill(0);
  box22.setStatic(true);
  box22.setRestitution(3.0);
  box22.setRotation(radians(80));
  world.add(box22);

  FBox box23=new FBox(40, 5);
  box23.setPosition(950, 330);
  box23.setFill(0);
  box23.setStatic(true);
  box23.setRestitution(2.0);
  box23.setRotation(radians(-35));
  world.add(box23);

  FBox box24=new FBox(40, 5);
  box24.setPosition(850, 130);
  box24.setFill(0);
  box24.setStatic(true);
  box24.setRestitution(0.5);
  box24.setRotation(radians(10));
  world.add(box24);

  FBox box25=new FBox(100, 5);
  box25.setPosition(560, 440);
  box25.setFill(0);
  box25.setStatic(true);
  box25.setRestitution(0);
  world.add(box25);

  FCircle midbox26=new FCircle(5);
  midbox26.setPosition(500, 520);
  midbox26.setStatic(true);
  midbox26.setNoFill();
  midbox26.setNoStroke();
  world.add(midbox26);

  box26=new FBox(5, 150);
  box26.setPosition(500, 490);
  box26.setFill(0);
  world.add(box26);

  FDistanceJoint joint26=new FDistanceJoint(box26, midbox26);
  joint26.setAnchor1(0, 30);
  joint26.setAnchor2(0, 0);
  joint26.setLength(0);
  world.add(joint26);

  box27=new FBox(40, 5);
  box27.setPosition(560, 550);
  box27.setFill(0);
  box27.setStatic(true);
  box27.setRestitution(2.0);
  world.add(box27);

  box28=new FBox(40, 5);
  box28.setPosition(660, 550);
  box28.setFill(0);
  box28.setRotation(radians(2));
  box28.setStatic(true);
  box28.setRestitution(1.5);
  world.add(box28);

  box29=new FBox(40, 5);
  box29.setPosition(780, 550);
  box29.setFill(0);
  box29.setRotation(radians(4));
  box29.setStatic(true);
  box29.setRestitution(2.0);
  world.add(box29);

  fin=new FPoly();
  fin.setPosition(938, 445);
  fin.setNoFill();
  fin.setNoStroke();
  fin.vertex(0, 50);
  fin.vertex(50, 50);
  fin.vertex(50, 0);
  fin.vertex(45, 0);
  fin.vertex(45, 45);
  fin.vertex(5, 45);
  fin.setRotation(radians(45));
  fin.setRestitution(0.0);
  fin.setStatic(true);
  world.add(fin);
}
void draw()
{
  background(240, 168, 96);
  for (int i=0; i<2; i++)
  {
    for (int j=0; j<4; j++)
    {
      if (i%2==0)
      {
        gearbox[i][j]. setRotation (radians (45*j+angle)) ;
      } else
      {
        gearbox [i][j]. setRotation (radians (15+45*j-angle)) ;
      }
    }
  }
  angle++;
  if (wheel2.isTouchingBody(box14)==true)
  {
    for (int i=0; i<9; i++)
    {
      domino[i].setStatic(true);
    }
    for (int i=0; i<8; i++)
    {
      domino2[i].setStatic(true);
    }
    world.remove(trolley);
    world.remove(wheel1);
    world.remove(wheel2);
    world.setGravity(0, -500);
  }
  if (hook.isTouchingBody(box15)==true)
  {
    world.setGravity(0, 1000);
    hook.setStatic(false);
  }
  if (box27.isTouchingBody(cir)==true)
  {
    cir.setSize(25);
  }
  if (box28.isTouchingBody(cir)==true)
  {
    cir.setSize(20);
  }
  if (box29.isTouchingBody(cir)==true)
  {
    cir.setSize(15);
  }
  if (cir.isTouchingBody(fin)==true)
  {
    cir.setNoStroke();
    textSize(100);
    fill(240, 96, 96);
    text("F", 870, 560);
    noStroke();
    rect(934, 512, 8, 50);
    textSize(100);
    fill(240, 96, 96);
    stroke(0);
    text("n", 950, 560);
  }

  pushMatrix();
  for (int i=0; i<3; i++)
  {
    translate(0, 40);
    stroke(240, 48, 48);
    strokeWeight(4);
    line(375, 400, 355, 420);
    line(355, 420, 355, 440);
    line(355, 440, 375, 420);
    line(375, 420, 395, 440);
    line(395, 440, 395, 420);
    line(395, 420, 375, 400);
  }
  popMatrix();
  fill(0);
  textSize(25);
  text("Press space to start", 30, 40);
  world.step();
  world.draw();
}
void keyPressed()
{
  if (keyCode==' ')
  {
    circle1.setAsCircle(100, 100, 30, 20);
    circle1.setPosition(100, 100);
    circle1.setFill(240, 96, 96);
    circle1.setDensity(1.0);
    world.add(circle1);
  }
}
