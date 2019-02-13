<?php
trait sanar{
	public function substrhtml($str,$start,$len){
     
        $str_clean = substr(strip_tags($str),$start,$len);
        $pos = strrpos($str_clean, " ");
        if($pos === false) {
            $str_clean = substr(strip_tags($str),$start,$len);  
            }else
            $str_clean = substr(strip_tags($str),$start,$pos);
     
        if(preg_match_all('/\<[^>]+>/is',$str,$matches,PREG_OFFSET_CAPTURE)){
     
            for($i=0;$i<count($matches[0]);$i++){
     
                if($matches[0][$i][1] < $len){
     
                    $str_clean = substr($str_clean,0,$matches[0][$i][1]) . $matches[0][$i][0] . substr($str_clean,$matches[0][$i][1]);
     
                }else if(preg_match('/\<[^>]+>$/is',$matches[0][$i][0])){
     
                    $str_clean = substr($str_clean,0,$matches[0][$i][1]) . $matches[0][$i][0] . substr($str_clean,$matches[0][$i][1]);
     
                    break;
     
                }
     
            }
     
            return $str_clean;
     
        }else{
            $string = substr($str,$start,$len);
             $pos = strrpos($string, " ");
            if($pos === false) {
                return substr($str,$start,$len);
            }
                return substr($str,$start,$pos);
     
        }
     
    }

    public static function sanar($contenido=''){
      if($contenido!=''){
      //$curado=str_replace (array_keys (ENTIDADES), array_values (ENTIDADES),$contenido);
      #<p><a><h1><h2><h3><h4><h5><h6><b><a><img><ul><li><span><pre><code><strong><ol><ul><label>
        $cadena='<pre><code><strong><img><b>';
      $curado=strip_tags($contenido,$cadena);
      $curado=str_replace('&nbsp;','',$curado);
      $curado=str_replace('<h1>','<h2 style="color:black">',$curado);
      $curado=str_replace('<h1>','</h2>',$curado);
      $curado=str_replace('<p></p>','',$curado);
      $curado=preg_replace('/\<p>\s?<br>\s?<\/p>/','',$curado);
      $curado =preg_replace('~style\s?=\s?["|\']([^}]+?)["|\']~','',$curado);
      return $curado;
      }
    

  }
}