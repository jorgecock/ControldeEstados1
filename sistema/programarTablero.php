<?php
	session_start();
	//if($_SESSION['rol']!=1){
	//	header("location: ./");
	//}
	
	$estadopagina=1; //entrandoorden

	include "scripts.php";
	include "functions.php";
	include "definicionmodulo.php";
	include "includes/scripts.php";
	include "validacionestadoactualTablero.php";

?>


<!DOCTYPE html>
<html>
<head>
	<title>Sin programar modulo visualizado en tablero</title>
	<meta charset="utf-8">
	<meta http-equiv="refresh" content="5">
</head>
<body align='center' onload="mueveReloj()">	
	<div>
		<hr size="8px" color="black" />
		<form name="form_reloj" align="left">
			<input type="text" name="reloj" style="font-size : 14pt; text-align : left;" onfocus="window.document.form_reloj.reloj.blur()">
		</form>
		<h3 align='left'> Fecha: <?php echo date("d/m/Y"); ?></h3>
		
		<!-- Nombre modulo  -->
		<?php
			include "../conexion.php";
			$query_tipo = mysqli_query($conexion,"
				SELECT nombremodulo 
				FROM modulos 
				WHERE idmodulo=$mod");
			mysqli_close($conexion);
			$result_tipo = mysqli_num_rows($query_tipo);
			if($result_tipo>0){
				$data= mysqli_fetch_array($query_tipo);
				$nombremodulo = $data['nombremodulo'];
			}else {
				echo ('error nombre modulo');					
			}
		?>
		<h1 align='center'>MODULO: <?php echo $nombremodulo; ?></h1>
		


		<h1>En espera a ser programado.</h1>
		<br>
		<a href="index.php">Regresar a la ventana de inicio</a>
	  	

	  	<!-- Cambio de modulo  -->
	  	<hr size="8px" color="black" />
		Número de módulo a seguir.<br>
		<select id="mySelect" name="selectmod" onchange="cambiodemodulo(this.value)">
			<?php
				//obtener numero de modulos configurados a hacer seguimiento para select 
				include "conexion.php";
				$query1 = mysqli_query($conexion,"SELECT * FROM modulos");
				mysqli_close($conexion);
				$result1=mysqli_num_rows($query1);

				for($i=1;$i<=$result1;$i++){
					$tipoa= mysqli_fetch_array($query1);
			?>	
			
			<option value="<?php echo $tipoa['idmodulo']; ?>" <?php echo ($tipoa['idmodulo']==$mod)? "selected":"";?>><?php echo $tipoa['nombremodulo'];?>
			</option>
			
			<?php 
				}
			?>
		</select>

		<script>
			function cambiodemodulo(val) {
	  		url="programarTablero.php?mod="+val;
	  		location.replace(url);
			}
		</script>
	</div>
	<br>
	<?php  include "includes/footer.php"; ?>
</body>
</html>