(define (problem robots-granny-house-problem)
  (:domain robots-granny-house)
  (:objects
    garage bathroom bedroom kitchen living_room - room
    doorA doorB doorC doorD doorE - door
    tools clothes silverware towel - util
    tay - robot
    robot_gripper - gripper
    granny - human
  )
  (:init
    ; Objests are in no corresponding rooms at the start:
    (object_at tools living_room)
    (object_at clothes garage)
    (object_at silverware bathroom)
    (object_at towel garage)
    ; Robot at garage and granny in bedroom:
    (robot_at tay garage)
    (human_at granny bedroom)
    ; Robot is carrying the silverware in the gripper:
    (gripper_at robot_gripper tay)
    ;(gripper_free robot_gripper) no esta libre el gancho ya que va a llevar un objeto consigo
    (robot_carry tay robot_gripper silverware)
    ; Declare map (Using "home" gazebo's map edited):
    (connected_by_door kitchen bathroom doorA)
    (connected_by_door bathroom kitchen doorA)
    (connected_by_door kitchen bedroom doorB)
    (connected_by_door bedroom kitchen doorB)
    (connected_by_door living_room garage doorC)
    (connected_by_door garage living_room doorC)
    (connected_by_door bedroom garage doorD)
    (connected_by_door garage bedroom doorD)

    (connected_by_door kitchen living_room doorE)
    (connected_by_door living_room kitchen doorE)

    ; All doors except C are closed:
    (close doorA)
    (close doorB)
    (open doorC)
    (close doorD)

    ; Granny request to take the clothes, open door "A" and close door "C":
    (open_door_request granny doorA)
  )

  (:goal
    (and
      ;Objects must be in their corresponding room:
      (move_object clothes bedroom)
      (move_object tools garage)
      (move_object towel bathroom)
      (move_object silverware kitchen)

      ; Door "A" must be open and the rest closed:
      (open doorA)
      (close doorB)
      (close doorC)
      (close doorD)

      ; Human (in this case, granny) must be attended:
      (human_attended granny)
    )
  )
)
