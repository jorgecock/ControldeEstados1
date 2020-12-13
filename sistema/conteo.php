<?php
	session_start();
	//if($_SESSION['rol']!=1){	
	//	header("location: ./");
	//}
	
	$estadopagina=3; //contando

	include "scripts.php";
	include "functions.php";
	include "definicionmodulo.php";
	include "includes/scripts.php";




	include "conexion.php";
	$query2 = mysqli_query($conexion,"
				SELECT u.*, r.numeroordenproduccion , s.nombre  
				FROM modulos u 
				INNER JOIN ordenesproduccion r ON u.ordendeprod=r.idordenproduccion
				INNER JOIN producto s ON  u.itemaproducir=s.idproducto
				WHERE u.idmodulo=$mod");
	$data=mysqli_fetch_array($query2);
	
	$tiempoacumuladoanterior=$data['tiempoacumulado'];
	$momentoinidespausa=$data['momentoinidespausa'];
	$tiempoactual=strtotime("now");
	$momentodepausa=$tiempoactual;
	$tiempocicloesperado=$data['tiempocicloesperado'];
	$productoshechos=$data['productoshechos'];
	$unidadesesperadas=$data['unidadesesperadas'];
	$porcentajecompletado=$productoshechos*100/$unidadesesperadas;
	$ordendeprod=$data['numeroordenproduccion'];
	$itemaproducir=$data['nombre'];
	$idproducto=$data['itemaproducir'];
	$idordenproduccion=$data['ordendeprod'];
	$ultimotiempodeproduccion=$data['ultimotiempodeproduccion'];
	$prodhechosdespausaini=$data['prodhechosdespausaini'];
	$tiempopasadodesdeultimoreinicio=($tiempoactual-$momentoinidespausa);
	$nuevotiempoacumuladoanterior=$tiempopasadodesdeultimoreinicio+$tiempoacumuladoanterior;
	$tiempoacumtrabajo=$tiempopasadodesdeultimoreinicio+$tiempoacumuladoanterior;
	$eficiencia=$productoshechos*100/(($tiempoacumtrabajo/60)/$tiempocicloesperado);
	$pausashechas=$data['pausashechas'];
	$tiempopausado=$data['tiempopausado'];

	//Definicion de estado siguiente

	if (isset($_POST)){
		//Selecciona a la pagina del siguiente estado con la funcion de salida para iniciar el estado siguiente
		if (isset($_POST['pausa'])){
			
			$siguienteestado=4; //pasa a estado pausa
			$pausashechas=$pausashechas+1;

			$query1 = mysqli_query($conexion,"
				UPDATE modulos
				SET estado=$siguienteestado, tiempoacumulado=$nuevotiempoacumuladoanterior, momentodepausa=$momentodepausa, eficienciaacumulada=$eficiencia, pausashechas=$pausashechas
				WHERE idmodulo=$mod");
			mysqli_close($conexion);
			header("location: pausa.php");
		} 

		if (isset($_POST['terminar'])){
			
			$siguienteestado=6; //pasa a estado terminado
			
			include "conexion.php";
			$query1 = mysqli_query($conexion,"
				UPDATE modulos
				SET estado=$siguienteestado, tiempoacumulado=$nuevotiempoacumuladoanterior, momentodepausa=$momentodepausa, eficienciaacumulada=$eficiencia
				WHERE idmodulo=$mod");
			mysqli_close($conexion);
			header("location: reportefinal.php");
		}
	}

	include "validacionestadoactual.php";

	include "conexion.php";
	$query2 = mysqli_query($conexion,"SELECT * FROM modulos WHERE idmodulo=$mod");
	mysqli_close($conexion);
	$data=mysqli_fetch_array($query2);
?>


<!DOCTYPE html>
<html>
<head>
	<title>Estado 3 Contando</title>
	<meta charset="utf-8">
	<meta http-equiv="refresh" content="5">
</head>
<body onload="mueveReloj()">
	<!--Encabezado -->
	<div>	
		<?php include "includes/header.php"; ?>	
		<br><br><br><br>
	</div>	

	<!--Columna izquierda -->
	<div style="padding: 10px; float: left; width: 50%; text-align: justify;">
		<hr size="8px" color="black" />
		<form name="form_reloj">
			<input type="text" name="reloj" style="font-size : 14pt; text-align : left;" onfocus="window.document.form_reloj.reloj.blur()">
		</form>
		<h3 align='left'> Fecha: <?php echo date("d/m/Y"); ?></h3>
		<h1 align="center">MODULO <?php echo $mod; ?></h1>
		<hr size="3px" color="black" />
		<h1 style='background-color:#F7F561;'>Conteo de producción</h1>
		<hr size="3px" color="black" />
		<h3>Orden de producción: <?php echo $ordendeprod; ?><br>Item a producir: <?php echo $itemaproducir; ?></h3>
		<hr size="3px" color="black" />
		<h3>Unidades terminadas actualmente: <?php echo $productoshechos; ?><br>
		<h3>Unidades terminadas luego del inicio o de la última pausa: <?php echo $prodhechosdespausaini; ?><br>
		Unidades programadas: <?php echo $unidadesesperadas; ?><br>
		Porcentaje completado: <?php echo round($porcentajecompletado,2); ?> %</h3>
		<hr size="3px" color="black" />
		
		<h3>Ultimo tiempo de ciclo realizado: 
		<?php 
			if ($prodhechosdespausaini > 1){
				//primer producto despues de inicio o de pausa
				echo round($ultimotiempodeproduccion,2)." minutos, ".round($ultimotiempodeproduccion*60,2)." segundos"; 
				$eficienciaultimociclo=round($tiempocicloesperado*100/$ultimotiempodeproduccion,2)." %";
			}else{
				//segundo producto en adelante.
				echo ("No aplica para la primera unidad hecha despues del inicio de producción o luego de renudar por algún tipo de pausa.");
				$eficienciaultimociclo=" No aplica para la primera unidad hecha despues del inicio de producción o luego de renudar por algún tipo de pausa.";
			}
		?>
		<br>
		Tiempo de ciclo esperado: <?php echo $tiempocicloesperado; ?> minutos, <?php echo $tiempocicloesperado*60; ?> segundos.<br>
		Eficiencia del ultimo ciclo: <?php echo $eficienciaultimociclo; ?><br>
		</h3>
		<h3>Eficiencia Acumulada: <?php echo round($eficiencia,2); ?></h3> 
		<h3>Tiempo Acumulado trabajado total en minutos: <?php echo round($tiempoacumtrabajo/60,2); ?>, en segundos: <?php echo round($tiempoacumtrabajo,2); ?></h3>
		<h3>Tiempo transcurrido desde la ultima pausa en minutos: <?php echo round($tiempopasadodesdeultimoreinicio/60,2); ?>, en segundos: <?php echo round($tiempopasadodesdeultimoreinicio,2); ?></h3>
		<h3>Pausas hechas: <?php echo ($pausashechas); ?></h3> 
		<h3>Tiempo acumulado en pausas en minutos: <?php echo round($tiempopausado/60,2); ?>, en segundos: <?php echo ($tiempopausado); ?></h3>
		<hr size="3px" color="black" />
	</div>

	<!--columna derecha -->
	<div style="padding: 10px; float: right; width: 50%; text-align: justify;"	>
		
		<?php
			
			$idmodulo=$mod;
			$fecha=date('y-m-d');

			include "conexion.php";
			$query1 = mysqli_query($conexion,"
				SELECT *
				FROM registroeficiencias
				WHERE (ordendeprod='$idordenproduccion' AND itemaproducir='$idproducto' AND modulo=$idmodulo AND (fechahora LIKE '%$fecha%'))" );
				include "conexion.php";
	
			$result = mysqli_num_rows($query1);
			if($result>0){
				while ($data=mysqli_fetch_array($query1)) {
					$eficiencias[]=$data;		
				}

				$query_tipo = mysqli_query($conexion,"
								SELECT nombremodulo FROM  modulos    
								WHERE (status=1 AND idmodulo=$idmodulo)");
				$tipoa= mysqli_fetch_array($query_tipo);
				$nombremodulo=$tipoa['nombremodulo'];
				
				$query_tipo = mysqli_query($conexion,"
								SELECT numeroordenproduccion FROM  ordenesproduccion    
								WHERE (status=1 AND idordenproduccion=$idordenproduccion)");
				$tipoa= mysqli_fetch_array($query_tipo);
				$numeroordenproduccion=$tipoa['numeroordenproduccion'];

				$query_tipo = mysqli_query($conexion,"
								SELECT nombre FROM  producto    
								WHERE (status=1 AND idproducto=$idproducto)");
				$tipoa= mysqli_fetch_array($query_tipo);
				$nombre=$tipoa['nombre'];
			}else{
				$eficiencias=[];
			}
			mysqli_close($conexion);
		?>
		<hr size="3px" color="black" />
				

		<table id="" class="table table-striped table-bordered">
			<tr>
				<th>Hora</th>
				<th>Cantidad Esperada</th>
				<th>Cantidad Hecha</th>
				<th>Eficiencia Acumulada</th>
			</tr>
			
			<tbody>
				<?php foreach($eficiencias as $eficiencia) { ?>
					<tr>
						<td><?php echo substr($eficiencia['fechahora'], 11) ; ?></td>
						<td><?php echo $eficiencia['cantidadesperada']; ?></td>
						<td><?php echo $eficiencia['cantidadhecha']; ?></td>
						<td><?php echo (round($eficiencia['eficiencia'],2)."%"); ?></td>
					</tr>
				<?php } ?>
			</tbody>	
		</table>
		<hr size="3px" color="black" />

		<div>
		<form method="post" action="">
			<input type="submit" name="pausa" value="pausa"><br> 
			<input type="submit" name="terminar" value="terminar">
			<!-- <a href="index.php">Regresar a la ventana de inicio</a> -->
		</form>	
		<hr size="8px" color="black" />
		Numero de módulo a seguir.<br>

		<select align='center' id="mySelect" name="selectmod" onchange="cambiodemodulo(this.value)">
			<?php
			include "conexion.php";
			$query1 = mysqli_query($conexion,"SELECT * FROM modulos");
			mysqli_close($conexion);
			$result1=mysqli_num_rows($query1);
			echo $result1;
			for($i=1;$i<=$result1;$i++){
			?>	
				<option value="<?php echo $i; ?>" <?php echo ($i==$mod)? "selected":"";?>><?php echo $i;?></option>
			<?php 
			}
			?>
		</select>

		<script>
			function cambiodemodulo(val) {
	  		url="conteo.php?mod="+val;
	  		location.replace(url);
			}
		</script>
	</div>

	<!--pie de pagina -->
	</div>
	<div style="padding: 0px 10px 10px 10px; float: right; width: 100% ; text-align: justify;">
		<?php  include "includes/footer.php"; ?>
	</div>
</body>
</html>