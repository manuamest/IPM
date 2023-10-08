# Curso 22/23. Práctica 3. Interfaces gráficas para aplicaciones web

![Image of the assigment](pexels-pixabay-270408.jpg)

_Repositorio dedicado al desarrollo de la tercera práctica de equipo
de IPM_

La práctica consiste en la realización de tres ejercicios en los que
ejercitar aspectos propios del desarrollo de interfaces para
aplicaciones web como pueden ser el uso de estándares y html
semántico, el diseño _responsive_, o la accesibilidad.


## Contributors:

- González Trillo, Cristian : cristiantrillo : cristian.gonzalez.trillo@udc.es
- Cidrás Fernández, Clara : claracidras : clara.cidras@udc.es
- Amestoy López, José Manuel : manuamest : manuel.amestoy@udc.es


## Welcome :wave:

- **Who is this for**: Grupos de prácticas de la asignatura _IPM_.

- **What you'll learn**: Uso de estándares web, html semántico, diseño
  responsive, accesibilidad.

- **What you'll build**: Realizareis tres ejercicios dirigidos a la
  implementación de interfaces web.

- **Prerequisites**: Asumimos que conocéis los recursos necesarios
  para consultar la información técnica de los lenguajes empleados y
  validar la implementación realizada.

- **How long**: Este assignment está formado por tres ejercicios. La
  duración estimada de cada ejercicio es de una semana lectiva.


## Pasos para comenzar el assignment:

1. Cubrir la lista _Contributors_ siguiendo el formato dado.


<details id=1>
<summary><h2>Ejercicio 1</h2></summary>

### :wrench: Este ejercicio tiene las siguientes partes:

  1. Crear un documento html5 utilizando html semántico. El documento
     tiene que contener los siguientes componentes:
  
  	  - Una cabecera de documento. La cabecera contiene un texto
        corto.
	  
      - Un contenido principal con dos partes:
      
        - La primera parte contiene un párrafo de texto seguido de una
          lista no ordenada. Los items de la lista contienen una
          imagen y un texto.
          
        - La segunda parte contiene un formulario con los siguientes
          campos de entrada: un campo de texto genérico, una fecha, un
          número entre 1 y 10 y una selección de tres opciones. El
          formulario también tendrá un botón tipo _submit_
          
      - Un pie de página. El contenido del pie de página queda a
        vuestro criterio.

     > :warning: Asegúrate de que el documento sigue el estándar y la 
     > herramienta de validación no informa de ningún error.
     
     > :warning: Asegúrate de seguir el principio de html semántico.
     
     > :warning: Asegúrate de que la experiencia de usuaria es la mejor
     > posible a la hora de cubrir el formulario. Pon especial
     > atención a las usuarias de navegadores de dispositivos móviles.
     
     
  2. Enlazar el documento con una hoja de estilos css3. El css debe
     establecer las propiedades de color, fuentes, bordes, margenes,
     ... El css no debe establecer ninguna propiedad relacionada con
     el _layout_ de la página, i.e. no debe alterar la posición de los
     elementos del documento.
     
     No elijas tú los valores de las propiedades. Usa los valores
     definidos en algunos de los _tokens de diseño_ que puedes
     encontrar en el siguiente repositorio:
     [https://github.com/sturobson/Awesome-Design-Tokens](https://github.com/sturobson/Awesome-Design-Tokens)

     Indica en un comentario del css el nombre del diseño de tu
     elección.
  
     > :warning: Sólo tienes que copiar los valores que especifica el
     > diseño elegido, no tienes que usar los recursos o herramientas
     > del repositorio.

     > :warning: Asegúrate de que la hoja de estilos sigue el estándar
     > y la herramienta de validación no informa de ningún error.
  

  > **Note** Si necesitas un servidor web básico, sin necesidad de
  > instalar ningún software adicional, puedes usar el que está
  > incorporado en la librería estándar de python: `python3 -m
  > http.server`
  
  
### :books: Objetivos de aprendizaje:

  - Uso de estándares, html semántico.
  
</details>


<details id=2>
<summary><h2>Ejercicio 2</h2></summary>

### :wrench: Este ejercicio tiene las siguientes partes:

  1. Extiende el documento del ejercicio anterior para validar los
     datos del formulario e informar a la usuaria de posibles errores.
	 Considera que son obligatorios todos los campos excepto la fecha.
     
     Realiza este paso cumpliendo con los criterios de accesibilidad
     del W3C.
     
  2. Extiende el documento del ejercicio anterior para añadir la
     siguiente funcionalidad: al activar el _submit_ del formulario,
     se añade un nuevo ítem al final de la lista. Dicho ítem se
     construye teniendo en cuenta que la imagen se corresponde con la
     opción seleccionada de las tres posibles, y el texto incluye los
     datos del resto de campos.

     Realiza este paso cumpliendo con los criterios de accesibilidad
     del W3C.


  En este ejercicio necesitarás añadir código javascript. Elige una
  versión del lenguaje y añade un comentario con esa
  información. Asegúrate que los principales navegadores soporta esa
  versión de javascript desde hace al menos dos años.
  
  > :warning: No olvides que los criterios de accesibilidad afectan
  > tanto al contenido estático del documento, como al dinámico.

  > :warning: Asegúrate de que el código javascript no accede al DOM
  > antes de que el navegador lo haya hecho disponible.

  > :warning: Asegúrate de seguir los estándares y que las
  > herramientas de validación no informan de ningún error.

  
### :books: Objetivos de aprendizaje:

  - Accesibilidad.
  
  - Uso del DOM.
  
  - Cross-browser.
  
</details>



<details id=3>
<summary><h2>Ejercicio 3</h2></summary>

### :wrench: Este ejercicio tiene las siguientes partes:

  1. Comprueba que el diseño de la página web es correcto cuando la
     usuaria accede con el navegador de un teléfono móvil, tanto en
     vertical como horizontal. Si no es el caso, cambia el css para
     modificar tamaños, margenes, etc. No cambies la posición de los
     elementos del documento.

  2. Considera dos configuraciones de navegadores más: en tablet, y en
     escritorio. Modifica el css para que el tamaño y posición de los
     elementos del documento se adapten a un diseño más adecuado para
     cada configuración.
	 
	 Algunos ejemplos para lograr los distintos diseños:
	 
	 - variar el _layout_ de los elementos del formulario: vertical,
       columnas, etiqueta encima del campo, etiqueta al lateral del
       campo, ...
	 
	 - variar el _layout_ del contenido principal, lista y formulario:
       vertical, dos columnas, ...
	   
     - convertir el formulario en un diálogo
	 
	 - ...
	 
  Según sea necesario en cada parte, emplea las técnicas de diseño
  fluido y responsive. Busca información estadística actualizada para
  determinar los puntos de ruptura de tablet y escritorio.
  
  > :warning: Usa las partes de los estándares que están soportadas
  > por los principales navegadores desde el comienzo del curso.

  > :warning: Asegúrate de seguir los estándares y que las
  > herramientas de validación no informan de ningún error.
  
  
### :books: Objetivos de aprendizaje:

  - Diseño fluido.
  
  - Mobile-first.
  
  - Responsive design.

</details>


<details id=X>
<summary><h2>Finish</h2></summary>

_Congratulations friend, you've completed this assignment!_

Una vez terminada la práctica no olvidéis revisar el contenido del
repositorio en Github y comprobar su correcto funcionamiento antes de
realizar la defensa.

</details>

