<?php
class tools{
    private function  autolink($message) {
        //Convert all urls to links
        $message = preg_replace('#([s|^])(www)#i', '$1http://$2', $message);
        $pattern = '#((http|https|ftp|telnet|news|gopher|file|wais)://[^s]+)#i';
        $replacement = '<a href="$1" target="_blank">$1</a>';
        $message = preg_replace($pattern, $replacement, $message);

        /* Convert all E-mail matches to appropriate HTML links */
        $pattern = '#([0-9a-z]([-_.]?[0-9a-z])*@[0-9a-z]([-.]?[0-9a-z])*.';
        $pattern .= '[a-wyz][a-z](fo|g|l|m|mes|o|op|pa|ro|seum|t|u|v|z)?)#i';
        $replacement = '<a href="mailto:1">1</a>';
        $message = preg_replace($pattern, $replacement, $message);
        return $message;
    }

    private function format_size($size) {
      $sizes = filesize($size);
      $sizes = array(" Bytes", " KB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB");
      if ($size == 0) { return('n/a'); } else {
      return (round($size/pow(1024, ($i = floor(log($size, 1024)))), 2) . $sizes[$i]); }
    }

    public function RemoveExtension($strName){
     $ext = strrchr($strName, '.');
     if($ext !== false)
     {
         $strName = substr($strName, 0, -strlen($ext));
     }
     return $strName;
    }

    public function get_extension($filename){
      $myext = substr($filename, strrpos($filename, '.'));
      return str_replace('.','',$myext);
    }

    public function encryptDecrypt($key, $string, $decrypt){
        if($decrypt)
        {
            $decrypted = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($key), base64_decode($string), MCRYPT_MODE_CBC, md5(md5($key))), "12");
            return $decrypted;
        }else{
            $encrypted = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($key), $string, MCRYPT_MODE_CBC, md5(md5($key))));
            return $encrypted;
        }
    }

    public function clean_none_ascii($output) {
        $output = preg_replace('/[^(x20-x7F)]*/','', $output);
        return $output;
    }

    public function get_percentage($percentage, $of){
        $percent = $percentage / $of;
        return  number_format( $percent * 100, 2 ) . '%';;
    }

}