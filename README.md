# planning-exercise

En este ejericio se pide un fichero PDDL con el dominio y varios (al menos 3) ficheros con el problema PDDL representativos.

El dominio debe permitir:

- Hacer que un robot navegue por una casa, formada por habitaciones, pasillos y puertas. Las puertas pueden estar abiertas o cerradas. El robot puede abrir (o pedir que le abran) puertas para poder moverse entre habitaciones.
- Puede haber objetos en diferentes puntos de la casa. Cada objeto tiene una habitación de la casa donde deberían estar, si la casa está ordenada. Desgraciadamente los objetos pueden estar en otros puntos de la casa, y el objetivo del robot es llevarlos a su sitio. Ejemplo de objetos:
  - Toallas: Baño
  - Platos y cubiertos: cocina
  - Herramientas: Garage
  - Ropa: Dormitorio
- Hay una persona en la casa (la abuelita), que generalmente está en su habitación. Podría estar en otro sitio.
- La abuelita podría pedir que hagas algo por ella, y esta tarea tendría prioridad sobre las tareas de recogida de objetos del robot. Ejemplo:
  - Abrir/cerrar la puerta de casa.
  - Traer un vaso de leche de la cocina.
  - Traer le medicina del salón.

Al menos, tened en cuenta los ejemplos descritos.

- En los fichero house_domain.\* esta el problema con durative actions pero sin tipos de habitaciones ni de objetos
- En los ficheros objects_domain.\* esta el problema hecho con durative actions, tipos de habitaciones y de objetos pero sin prioridades.
- En los ficheros house_granny.\* es donde falta implementar las prioridades. Metodo a intentar seguir: añadir un predicacio:= High_prioritity_exist donde no se moverá/cogerá nada si no es correspondiente a lo que tiene alta prioridad(pedido por la abuela)
