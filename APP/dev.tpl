<?php

function setReporting() {
if (DEV == true) {
    error_reporting(E_ALL);
    ini_set('display_errors','On');
} else {
    error_reporting(E_ALL);
    ini_set('display_errors','Off');
    ini_set('log_errors', 'On');
    ini_set('error_log', RAIZ.DS.'logs'.DS.'error.log');
}
}
setReporting();

if (DEVJS == true) { ?>

<script>

(function( context ){
  var globals = { viewGlobals : true },
      startGlobals = [],
      newGlobals = [];
 
  for (var j in window) {
    globals[j] = true;
    startGlobals.push(j);
  }
 
  setInterval(function() {
    for ( var j in window ) {
      if ( !globals[j] ) {
        globals[j] = true;
        newGlobals.push(j);
        console.warn( 'New Global: ' + j + ' = ' + window[j] + '. Typeof: ' + (typeof window[j]) );
      }
    }
  }, 1000);
 
  context.viewGlobals = function(){
    console.groupCollapsed( 'View globals' );
      console.groupCollapsed( 'Initial globals' );
        console.log( startGlobals.sort().join( ",\n" ) );
      console.groupEnd();
      console.groupCollapsed( 'New globals' );
        console.warn( newGlobals.sort().join( ",\n" ) );
      console.groupEnd();
    console.groupEnd();
  };
 
})(this);


</script>

<?php } ?>