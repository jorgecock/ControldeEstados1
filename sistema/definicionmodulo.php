<?php
	//Definicion de modulo
	if (isset($_GET['mod'])){
		$_SESSION['mod']=$_GET['mod'];
	}
	if (!isset($_SESSION['mod'])){
		$mod=1;	 //siempre debe haber un modulo 1 que no se puede borrar
		$_SESSION['mod']=1;
	} else {
		$mod=$_SESSION['mod'];
	}
?>