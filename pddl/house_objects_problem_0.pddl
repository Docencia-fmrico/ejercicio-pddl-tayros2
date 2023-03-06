(define (problem robots-objects-house-problem)
  (:domain robots-objects-house)
  (:objects
    garage bathroom bedroom kitchen - room
    DoorA DoorB DoorC DoorD - door
    Corridor - corridor
    tools clothes silverware towel - util
    robby walle - robot
    gripper1 gripper2 - gripper
  )
  (:init
    (robot_at robby garage)
    (robot_at walle garage)
    (gripper_at gripper1 robby)
    (gripper_at gripper2 walle)
    (gripper_free gripper1)
    (gripper_free gripper2)
    (object_at tools garage)
    (object_at clothes garage)
    (object_at silverware garage)
    (object_at towel garage)
    (connected garage Corridor DoorA)
    (connected bathroom Corridor DoorB)
    (connected bedroom Corridor DoorC)
    (connected kitchen Corridor DoorD)
    (connected Corridor garage DoorA)
    (connected Corridor bathroom DoorB)
    (connected Corridor bedroom DoorC)
    (connected Corridor kitchen DoorD)
    (close DoorA)
    (close DoorB)
    (close DoorC)
    (close DoorD)
  )

  (:goal
    (and
      (object_at tools garage)
      (object_at towel bathroom)
      (object_at clothes bedroom)
      (object_at silverware kitchen)
      ;¿Por que no funciona el forall, tampoco va en los eje
      ; ejemplos de moving_domain.*?
      ; (forall
      ;   (?b - ball)
      ;   (object_at ?b A)
      ; )
    )
  )
)
