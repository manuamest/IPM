let add = document.getElementById("sub");
function formatoFecha(fecha, formato) {
  const map = {
    dd: fecha.getDate(),
    mm: fecha.getMonth() + 1,
    yyyy: fecha.getFullYear(),
  };

  return formato.replace(/dd|mm|yyyy/gi, (matched) => map[matched]);
}
add.addEventListener("click", (event) => {
  event.preventDefault();
  let name = document.getElementById("nombre").value;
  let imgsrc = document.getElementById("img").value;
  let donacion = document.getElementById("don").value;
  let fecha = document.getElementById("fecha").value;
  let catname = imgsrc.slice(10, -4);
  let fechaAPrintear = new Date(Date.now());
  fechaAPrintear = formatoFecha(fechaAPrintear, "yyyy-mm-dd");
  if (name == "") {
    alert("No has escrito nada en el nombre");
    return;
  }
  if (imgsrc == "") {
    alert("No has escogido ningún michi");
    return;
  }
  if (donacion == "") {
    alert("No has elegido tu donación");
    return;
  }
  if (donacion >= 11 || donacion <= 0) {
    alert("Cantidad de donación incorrecta (1-10€)");
    return;
  }
  if (fecha != "") {
    fechaAPrintear = fecha;
  }
  let node = document.createElement("li");
  node.appendChild(document.createTextNode(fechaAPrintear));
  node.appendChild(document.createElement("br"));
  node.appendChild(
    document.createTextNode(
      catname + ": " + name + " ha donado " + donacion + "€"
    )
  );
  node.appendChild(document.createElement("br"));
  let image = document.createElement("img");
  image.src = imgsrc;
  image.alt = "Gato";
  image.width = 250;
  image.height = 250;
  node.appendChild(image);
  document.querySelector("ul").appendChild(node);
  document.getElementById("nombre").value = "";
  document.getElementById("img").value = "";
  document.getElementById("don").value = "";
  document.getElementById("fecha").value = "";
});

function openDialog(e, t) {
  var n = !1;
  void 0 !== t && (n = t);
  var a = document.getElementById(e);
  n ? a.showModal() : a.show();
}
function closeDialog(e) {
  document.getElementById(e).close();
}
function abrirDialogo(e, t) {
  openDialog(e, t);
}
function cerrarDialogo(e) {
  closeDialog(e);
}