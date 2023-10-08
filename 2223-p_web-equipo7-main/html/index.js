
const addItem = () => {
        try {
          let name = document.getElementById("nombre").value; // Obtemos nome seleccionado polo usuario
          
          
          let michi_path = document.getElementById("menu").value; // Obtemos tipo de michi seleccionado polo usuario
    
          var michi_img=document.createElement('img'); // Creamos a nova imaxe que imos agregar á lista
          michi_img.src=michi_path; // Declaramos ruta e tamaño da imaxe
          michi_img.width=250;
          michi_img.height=250;
    
          let userListElement = document.createElement("li");
          userListElement.innerHTML = name; // Engadimos o nome do michi no novo item
          userListElement.append(<br>michi_img</br>); // Engadimos a imaxe
    
          let list = document.getElementById("lista");
          list.appendChild(userListElement);
          document.getElementById("nombre").value = ""; 
        } catch (error) {
          console.error(error);
        }
};
