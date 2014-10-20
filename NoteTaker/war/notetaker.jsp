<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html ng-app="Notes">

<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>Note Taker</title>

  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.3/angular.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
  <script src="editable-div.js"></script>
  <script src="note-controller.js"></script> 

  <link rel="stylesheet" href="app.css">

  <link rel="stylesheet" href="/resources/demos/style.css" />

</head>

  <body>
<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<p> It is now <%= new java.util.Date() %> </p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to take some notes!
<%
    }
%>
<center>
<h2> Note Taker Version 2.0.0 </h2>   
<div ng:controller="NoteController">

  <input placeholder="Filter..." ng-model = "search"> </input>

  <br>
  
  <br>

  <textarea placeholder="Type new note here" ng-model="new_note"></textarea>
  <button type="button" ng-click="addNote()"> Add </button>

  <div ng:repeat="note in notes | filter:search">
  
    <editable-div ng-model="note.text"></editable-div>
    <p>
    <button type="button" ng-click="deleteNote(note.id)"> Delete </button>
    <button type="button" ng-click="pushNoteUp(note)" style="color:Blue"> <strong > &#8593; </strong> </button>
    <button type="button" ng-click="pushNoteDown(note)" style="color:Green"> <strong > &#8595;  </strong> </button>
    <button type="button" ng-click="deleteNote(note.id); pushNoteToTop(note)" style="color:Blue"> <strong >&#8648; </strong> </button>
    <button type="button" ng-click="deleteNote(note.id); pushNoteToBottom(note)" style="color:Green"> <strong >&#8650; </strong></button>
    <form action="/email" method="post">
      <div><input placeholder = "Email... " name="mailTo"></input></div>
      <div><input type="hidden" name="content" value= {{note.text}} ></input></div>
      <div><input type="submit" value="Send" /></div>
    </form>
    <p>
    <p>
    <p>
  </div>

<br>
<button type="button" ng-click="deleteAllNotes()" style="color:Red"> Delete All </button>

<br>
<br>

<table style="background-color:lightgray;" border="1">
  <caption>Rearranging Your Notes</caption>
  <tr>
    <th>Button</th>
    <th>Action</th>
  </tr>
  <tr>
    <td> <FONT COLOR="#0000FF">&#8593</FONT> </td>
    <td>push note up one</td>
  </tr>
  <tr>
    <td> <FONT COLOR="#008000"> &#8595</FONT> </td>
    <td>push note down one </td>
  </tr>
  <tr>
    <td> <FONT COLOR="#0000FF">&#8648</FONT> </td>
    <td>push note to top </td>
  </tr>
  <tr>
    <td> <FONT COLOR="#008000">&#8650</FONT> </td>
    <td>push note to bottom </td>
  </tr>
</table>

</div>
</center>
  </body>
</html>

</center>
  </body>
</html>


