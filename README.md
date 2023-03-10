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

# Resolución de este ejercicio

Para solucionar este ejercicio hemos usado utilizado reutilizado el codigo del repositorio proporcionado por nuestro profefor el cual podeis encontrar aqui: [repo](https://github.com/fmrico/planning_cognitve_systems_course/tree/main/pddl). (Concretamente el dominio de robots_domain)

Además, se nos solicitó el uso de durative actions en las acciones que nosotros creyésemos oportunas. En nuestro caso han sido las acciones: open-door, close-door, pick, pick_prio y drop. Ya que son acciones que realmente van a simular el comportamiento de un robot real en un entorno físico y que van a suponer un gasto de tiempo para el robot. El resto de acciones son usadas como misiones o submisiones para llegar a la meta deseada. También decidimos no hacer las acciones move_by_door y move_without_door reactive actions para resolver uno de los problemas que nos encontramos a la hora de resolver este problema.

Finalmente para resolver el apartado de la prioridad de la recogida de objetos solicitados por un humano(en este caso la abuela) decidimos usar un predicado (no_prio_task_remaining) como condición de la acción de pick, que solamente iba a darse si la abuela no ha solicitado recoger ningún objeto(en este caso hay que añadirlo en la parte de inicialización del problema) o si ya se ha realizado alguna de las acciones con prioridad solicitada por el humano. Y para que solo se recogiese el objeto que tenía prioridad, usamos como condición de la acción pick_prio, que ese fuese el objeto solicitado por la abuela (at start(pick_request ?h ?u)).

# Problemas que nos hemos encontrado durante la resolución del ejercicio:

1. Que el robot no cogiese más de un objeto a la vez.

Para nuestra implementación, decidimos simular que nuestro robot era el modelo tiago que tenemos en nuestros laboratorios y el cual parece ser apto para solo llevar un objeto a la vez.
El motivo por el cual esto supuso un problema es que al usar durative-actions, estábamos poniendo como efecto que al final de la acción el gancho estuviese ocupado, impidiendo que se recogiesen nuevos objetos, pero no impidiendo que en lo que se tardaba en realizar la acción, se cogiesen mas de uno. Para resolver esto, hicimos que este efecto se ejecutase al principio de la acción y no al final.

2. Que el robot no cambie de habitación a la vez por una puerta y por un sitio donde no hay puerta.

Uno de los requerimientos de este ejercicio es que nos basásemos en un entorno de nuestros simuladores(home) y que pudiese pasar también el robot de una habitación a otra sin tener porqué haber una puerta siempre y cuando estuviesen conectadas de algún modo. Para resolver esto, pensamos en varias maneras de como poder evitar que se ejecutasen las dos acciones a la vez; añadiendo predicados de "not_moving y moving", usando over alls, ... pero nada de esto parecía funcionar. Por esto decidimos hacer que las acciones move_by_door y move_without_door no fuesen durative_actions.

3. Uso de prioridades.

Intentamos utilizar contents como always-within, hold-after... pero no están soportados por popf y al final lo conseguimos resolver como hemos explicado en el último párrafo del punto "Resolución de este ejercicio".

# Problemas implementados

En el problema 0 se muestra el funcionamiento de la recogida de objetos con prioridad y como después el robot recoge el resto de objetos de la casa, en el 1 y 2 se muestra como funciona la apertura y cierre de puertas que solicita el humano y en el 3 como se recogen los objetos de la casa de forma normal al no haber ninguna petición de ningún humano.
