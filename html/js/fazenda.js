function btnCompra(){
	alert('COMPRA!!');
}

function mapHover(){
	
}

function displayCompra(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "initial");
}

function displayVenda(){
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoGadoVenda").css("display", "initial");
	$("#HistoricoGadoVenda table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/vendaTable.html";
}

function displayManejo(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "initial");
	$("#HistoricoGadoManejo table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/manejoTable.html";
}

function displayMorte(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "initial");
	$("#HistoricoGadoMorte table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/morteTable.html";
}

function displayTrato(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoTrato").css("display", "initial");
	$("#HistoricoTrato table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/tratoTable.html";
}

function displayManutencao(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoManutencao").css("display", "initial");
	$("#HistoricoManutencao table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/manutencaoTable.html";
}

function displayAdicao(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "initial");
}

function displayRemocao(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "initial");
}

function displayEmprestimo(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "initial");
}

function displayDevolucao(){
	$("#HistoricoGadoVenda").css("display", "none");
	$("#HistoricoGadoManejo").css("display", "none");
	$("#HistoricoGadoCompra").css("display", "none");
	$("#HistoricoGadoMorte").css("display", "none");
	$("#HistoricoTrato").css("display", "none");
	$("#HistoricoManutencao").css("display", "none");
	$("#HistoricoMaquinarioRemocao").css("display", "none");
	$("#HistoricoMaquinarioEmprestimo").css("display", "none");
	$("#HistoricoMaquinarioAdicao").css("display", "none");
	$("#HistoricoMaquinarioDevolucao").css("display", "initial");
}

function clearCompra() {
	$("#inputCompraData").val("");
	$("#inputCompraQuantidade").val("");
	$(".selectPasto").css("color", "#A0A0A0");
	$(".selectPasto").val("0");
	$("#inputCompraIdade").val("");
	$("#inputCompraVendedor").val("");
}

function clearVenda() {
	$("#inputVendaData").val("");
	$("#inputVendaQuantidade").val("");
	$(".selectPasto").css("color", "#A0A0A0");
	$(".selectPasto").val("0");
	$("#inputVendaIdade").val("");
	$("#inputVendaComprador").val("");
}

function clearMorte() {
	$("#inputMorteData").val("");
	$("#inputMorteCausa").val("");
	$("#inputMorteQuantidade").val("");
	$(".selectPasto").css("color", "#A0A0A0");
	$(".selectPasto").val("0");
	$("#inputMorteIdade").val("");
}

function clearManejo() {
	$("#inputManejoData").val("");
	$(".selectPasto").css("color", "#A0A0A0");
	$(".selectPasto").val("0");
	$("#inputManejoQuantidade").val("");
	$("#inputManejoIdade").val("");
}

function clearTrato() {
	$("#inputTratoData").val("");
	$("#inputTratoTipo").val("");
}

function clearManutencao() {
	$("#inputManutencaoData").val("");
	$("#inputManutencaoTipo").val("");
}

function clearAdicionar() {
	$("#inputAdicionarData").val("");
	$("#inputAdicionarTipo").val("");
	$("#inputAdicionarMarca").val("");
	$("#inputAdicionarGarantia").val("");
	$("#inputAdicionarQuantidade").val("");
}

function clearRemover() {
	$("#inputRemoverData").val("");
	$("#inputRemoverMotivo").val("");
}

function clearEmprestimo() {
	$("#inputEmprestimoData").val("");
	$("#inputEmprestimoPara").val("");
}

function clearDevolucao() {
	$("#inputDevolucaoData").val("");
}

function mapClick(pasto){
	$("#manejoModal").modal('hide');
	$("#tratoModal").modal('hide');
	$("#manutencaoModal").modal('hide');
	$("#pastoModal").modal();
	$("#pastoModalTitle").text(pasto);
	$("#pastoModalDiv table tbody tr").remove();
	//document.getElementById("gambiarraFrame").src = "/pastoTable.html";
	$.ajax({
		url: '/pastoTable.html',
		type: 'GET',
		data: {pasto: pasto},
		success: function(pasto){
			console.log(pasto);
		}
	});

}

function manejoClick(){
	$("#inputManejoPastoSaida").val($("#pastoModalTitle").text());
	$("#pastoModal").modal('hide');
	clearManejo();
	$("#manejoModal").modal('show');
	$("#manejoModal .modal-footer .btn-danger").attr("onClick", "mapClick(\"" + $("#pastoModalTitle").text() + "\")");
}

function tratoClick(){
	$("#inputTratoPastoSaida").val($("#pastoModalTitle").text());
	$("#pastoModal").modal('hide');
	clearTrato();
	$("#tratoModal").modal('show');
	$("#tratoModal .modal-footer .btn-danger").attr("onClick", "mapClick(\"" + $("#pastoModalTitle").text() + "\")");
}

function manutencaoClick(){
	$("#inputManutencaoPastoSaida").val($("#pastoModalTitle").text());
	$("#pastoModal").modal('hide');
	clearManutencao();
	$("#manutencaoModal").modal('show');
	$("#manutencaoModal .modal-footer .btn-danger").attr("onClick", "mapClick(\"" + $("#pastoModalTitle").text() + "\")");
}

function gColor(){
	$(".selectPasto").css("color", "#555");
}

function setHistoricoCompraURL(){
	location.href = "historicoCompra"
}

function addLineCompra(data, quantidade, pastoDestino, idade, vendedor){
	if(data != "")
		$("#HistoricoGadoCompra table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+quantidade+"</td>" +
										  				"<td>"+pastoDestino+"</td>" +
										  				"<td>"+idade+"</td>" +
										  				"<td>"+vendedor+"</td>" +
									  				  "</tr>");	
}

function addLinePasto(idade, quantidade, total, quantidadeTotal){
	$("#pastoModalDiv table tbody ").append("<tr>" +
										  			"<td>"+idade+"</td>" + 
										  			"<td>"+quantidade+"</td>" +
										  			"<td>"+total+"</td>" +
										  			"<td>"+quantidadeTotal+"</td>" +
									  			   "</tr>");	
}


function addLineVenda(data, quantidade, pastoSaida, idade, vendedor){
	if(data != "")
		$("#HistoricoGadoVenda table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+quantidade+"</td>" +
										  				"<td>"+pastoSaida+"</td>" +
										  				"<td>"+idade+"</td>" +
										  				"<td>"+vendedor+"</td>" +
									  				  "</tr>");	
}

function addLineManejo(data, pastodestino, quantidade, idade, pastosaida){
	if(data != "")
		$("#HistoricoGadoManejo table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+pastodestino+"</td>" +
										  				"<td>"+quantidade+"</td>" +
										  				"<td>"+idade+"</td>" +
										  				"<td>"+pastosaida+"</td>" +
									  				  "</tr>");	
}

function addLineMorte(data, causa, quantidade, pastosaida, idade){
	if(data != "")
		$("#HistoricoGadoMorte table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+causa+"</td>" +
										  				"<td>"+quantidade+"</td>" +
										  				"<td>"+pastosaida+"</td>" +
										  				"<td>"+idade+"</td>" +
									  				  "</tr>");	
}

function addLineTrato(data, tipo, pasto){
	if(data != "")
		$("#HistoricoTrato table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+tipo+"</td>" +
										  				"<td>"+pasto+"</td>" +
									  				  "</tr>");	
}

function addLineManutencao(data, tipo, pasto){
	if(data != "")
		$("#HistoricoManutencao table tbody ").append("<tr>" + 
										  				"<td>"+data+"</td>" + 
										  				"<td>"+tipo+"</td>" +
										  				"<td>"+pasto+"</td>" +
									  				  "</tr>");	
}

function updateCompraTable(){
	$("#HistoricoGadoCompra table tbody tr").remove();
	document.getElementById("gambiarraFrame").src = "/compraTable.html";
}

function validateCompraForm(){
	var a = document.forms["compraForm"]["data"].value;
	var b = document.forms["compraForm"]["quantidade"].value;
	var c = document.forms["compraForm"]["pastodestino"].value;
	var d = document.forms["compraForm"]["idade"].value;
	var e = document.forms["compraForm"]["vendedor"].value;

	if(a == "" || b == "" || c.length == 1 || d == "" || e == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

function validateVendaForm(){
	var a = document.forms["vendaForm"]["data"].value;
	var b = document.forms["vendaForm"]["quantidade"].value;
	var c = document.forms["vendaForm"]["pastosaida"].value;
	var d = document.forms["vendaForm"]["idade"].value;
	var e = document.forms["vendaForm"]["comprador"].value;

	if(a == "" || b == "" || c.length == 1 || d == "" || e == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

function validateMorteForm(){
	var a = document.forms["morteForm"]["data"].value;
	var b = document.forms["morteForm"]["causa"].value;
	var c = document.forms["morteForm"]["pastosaida"].value;
	var d = document.forms["morteForm"]["quantidade"].value;
	var e = document.forms["morteForm"]["idade"].value;

	if(a == "" || b == "" || c.length == 1 || d == "" || e == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

function validateManejoForm(){
	var a = document.forms["manejoForm"]["data"].value;
	var b = document.forms["manejoForm"]["pastodestino"].value;
	var c = document.forms["manejoForm"]["quantidade"].value;
	var d = document.forms["manejoForm"]["idade"].value;

	if(a == "" || b.length == 1 || c == "" || d == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

function validateTratoForm(){
	var a = document.forms["tratoForm"]["data"].value;
	var b = document.forms["tratoForm"]["tipo"].value;

	if(a == "" || b == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

function validateManutencaoForm(){
	var a = document.forms["manutencaoForm"]["data"].value;
	var b = document.forms["manutencaoForm"]["tipo"].value;

	if(a == "" || b == ""){
		alert("Preencha todos os campos!");
		return false;
	}
}

$(document).ready(function(){
	$("#gadoDropDownUl a").on("click", function(){
	   	$(".nav").find(".active").removeClass("active");
	   	$("#dropDownGado").addClass("active");
	});
	$("#maquinarioDropDownUl a").on("click", function(){
	   	$(".nav").find(".active").removeClass("active");
	   	$("#dropDownMaquinario").addClass("active");
	});
});

$(".modal-wide").on("show.bs.modal", function() {
  var height = $(window).height() - 200;
  $(this).find(".modal-body").css("max-height", height);
});

