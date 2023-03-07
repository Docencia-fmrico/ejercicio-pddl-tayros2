(define (problem robots-granny-house-problem)
  (:domain robots-granny-house)
  (:objects
    garage bathroom bedroom kitchen - room
    DoorA DoorB DoorC DoorD - door
    Corridor - corridor
    tools clothes silverware towel - util
    robby walle - robot
    gripper1 gripper2 - gripper
    granny - human
  )
  (:init
    (robot_at robby garage)
    (robot_at walle garage)
    (human_at granny bedroom)
    (gripper_at gripper1 robby)
    (gripper_at gripper2 walle)
    (gripper_free gripper1)
    (gripper_free gripper2)
    (object_at tools garage)
    (object_at clothes garage)
    (object_at silverware garage)
    (object_at towel garage)
    (connected_by_door garage Corridor DoorA)
    (connected_by_door bathroom Corridor DoorB)
    (connected_by_door bedroom Corridor DoorC)
    (connected_by_door kitchen Corridor DoorD)
    (connected_by_door Corridor garage DoorA)
    (connected_by_door Corridor bathroom DoorB)
    (connected_by_door Corridor bedroom DoorC)
    (connected_by_door Corridor kitchen DoorD)
    (close DoorA)
    (close DoorB)
    (close DoorC)
    (close DoorD)

    (= (priority tools) 1)
    (= (priority clothes) 1)
    (= (priority silverware) 1)
    (= (priority towel) 10)
  )

  (:goal
    (and
      (object_at tools garage)
      (object_at towel bathroom)
      (object_at clothes bedroom)
      (object_at silverware kitchen)
    )
  )
  (:metric minimize
    (cost)
  )
)
