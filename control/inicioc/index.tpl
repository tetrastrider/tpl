<?php
class inicioc extends controlador
{
	private $arreglo=array();
	private $antiguas=array();

		public function __construct(){
			
			parent::__construct();
		}

		public function index(){
			
		$ultimas = $this->modelo->ultimas();
		foreach($ultimas as $ult){$this->arreglo['titulo'][]=$ult['titulo'];$this->arreglo['foto'][]=$ult['foto'];}
		$god =array(array('baner'=>$this->arreglo['foto'][0],'titulo'=>$this->arreglo['titulo'][0],'id'=>'first','class'=>'firstanimation'),
					array('baner'=>$this->arreglo['foto'][1],'titulo'=>$this->arreglo['titulo'][1],'id'=>'second','class'=>'secondanimation'),
					array('baner'=>$this->arreglo['foto'][2],'titulo'=>$this->arreglo['titulo'][2],'id'=>'third','class'=>'thirdanimation'),
					array('baner'=>$this->arreglo['foto'][3],'titulo'=>$this->arreglo['titulo'][3],'id'=>'fourth','class'=>'fourthanimation'),
					array('baner'=>$this->arreglo['foto'][4],'titulo'=>$this->arreglo['titulo'][4],'id'=>'fifth','class'=>'fifthanimation'));
		$this->vista->eachset('slider',$god);
		/******************/
		$antigua = $this->modelo->antigua();
		foreach($antigua as $ant){$this->antiguas['titulo'][]=$ant['titulo'];$this->antiguas['foto'][]=$ant['foto'];}
		$g2 =array(array('baner2'=>$this->antiguas['foto'][0],'titulo2'=>$this->antiguas['titulo'][0],'id2'=>'first','class2'=>'firstanimation'),
					array('baner2'=>$this->antiguas['foto'][1],'titulo2'=>$this->antiguas['titulo'][1],'id2'=>'second','class2'=>'secondanimation'),
					array('baner2'=>$this->antiguas['foto'][2],'titulo2'=>$this->antiguas['titulo'][2],'id2'=>'third','class2'=>'thirdanimation'),
					array('baner2'=>$this->antiguas['foto'][3],'titulo2'=>$this->antiguas['titulo'][3],'id2'=>'fourth','class2'=>'fourthanimation'),
					array('baner2'=>$this->antiguas['foto'][4],'titulo2'=>$this->antiguas['titulo'][4],'id2'=>'fifth','class2'=>'fifthanimation'));
		$this->vista->eachset('s2',$g2);
		/******************/
		$g3 =array(array('baner3'=>'noticia.jpg','titulo3'=>'Cougar','id3'=>'first','class3'=>'firstanimation'),
					array('baner3'=>'ps4white.jpg','titulo3'=>'Lions','id3'=>'second','class3'=>'secondanimation'),
					array('baner3'=>'workers-feature.png','titulo3'=>'Snowalker','id3'=>'third','class3'=>'thirdanimation'),
					array('baner3'=>'relationalpseudos2.png','titulo3'=>'Howling','id3'=>'fourth','class3'=>'fourthanimation'),
					array('baner3'=>'revelado.png','titulo3'=>'Sunbathing','id3'=>'fifth','class3'=>'fifthanimation'));
		$this->vista->eachset('s3',$g3);
		/******************/
		$g4 =array(array('baner4'=>'css3-attr-selector-cover.jpg','titulo4'=>'Cougar','id4'=>'first','class4'=>'firstanimation'),
					array('baner4'=>'restful_api.jpg','titulo4'=>'Lions','id4'=>'second','class4'=>'secondanimation'),
					array('baner4'=>'default.jpg','titulo4'=>'Snowalker','id4'=>'third','class4'=>'thirdanimation'),
					array('baner4'=>'nodejs.png','titulo4'=>'Howling','id4'=>'fourth','class4'=>'fourthanimation'),
					array('baner4'=>'websocket-handshake-header.jpg','titulo4'=>'Sunbathing','id4'=>'fifth','class4'=>'fifthanimation'));
		$this->vista->eachset('s4',$g4);
		$this->vista->ver();
		 }


} 

?>

