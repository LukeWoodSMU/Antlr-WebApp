grammar Evil;

@header{
  import java.util.*;
  import java.net.*;
  import java.io.*;
  import javax.script.*;
}

@parser::members{

  String initial_url = "http://lyle.smu.edu/~lswood/dataService.php";

  BufferedReader getReader(String id, String key, String value){
    String url = initial_url;
    if(id != null){
        url = url+"?" + "id="+id;
    }
    if(id != null && key != null){
        url = url + "&key="+key;
    }
    if(id != null && key != null && value != null){
        url = url + "&val="+value;
    }
    try{

        URL u = new URL(url);
        URLConnection conn = u.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));

        return in;

    }catch(Exception e){
          e.printStackTrace();
    }
    return null;
  }
  void printAll(BufferedReader br){
    if(br == null){
      System.out.println("Error connecting to server!");
      return;
    }
    String complete = "";
    String line = null;
    try{
      while((line = br.readLine()) != null){
        complete += line;
      }

      if(complete.equals("null")){
        System.out.println("I have never heard of such an evil doer!");
      }
      else{
        System.out.println(complete);
      }
    }catch(Exception e){
      e.printStackTrace();
    }
  }

  void printJSON(BufferedReader br){
    String complete = "";
    String line = null;

    if(br == null){
      System.out.println("Error connecting to server!");
      return;
    }

    try{
      while((line = br.readLine()) != null){
        complete += line;
      }

      if(complete.equals("null")){
        System.out.println("I have never heard of such an evil doer!");
      }
      else{
        System.out.println(complete);
      }
    }catch(Exception e){
      e.printStackTrace();
      return;
    }

  }
}

expr: (listAll | listIndividual | listKey | setKey) '\n'?;

listAll: 	'TELL ME ALL ABOUT PURE EVIL!' {
  System.out.println("HERE IS EVERYTHING I KNOW ABOUT PURE EVIL:\n");
  printAll(getReader(null, null, null));
};

listIndividual: 'TELL ME ABOUT ' NAME {
  System.out.println("HERE IS EVERYTHING I KNOW ABOUT "+$NAME.text+":\n");
  printAll(getReader($NAME.text, null, null));
};

listKey: 'TELL ME ABOUT ' NAME ' AND ' KEY{
  System.out.println("HERE IS EVERYTHING I KNOW ABOUT "$NAME.text + " AND "+ $KEY.text)''
  printAll(getReader($NAME.text, $KEY.text,  null));
};

setKey: 'EVIL DOER ' NAME ' DESTROYED ' KEY ' USING ' MEANS{
  printAll(getReader($NAME.text, $KEY.text, $MEANS.text));
};

NAME:	'evilsorcerer' | 'gandalf' | 'professorCoyle' | 'momin';
KEY: 'SMU' | 'kittens' | 'bunnies' | 'happiness' | 'TCU';
MEANS: 'antlr' | 'magic' | 'steel' | 'cats';
