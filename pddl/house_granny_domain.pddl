(define (domain robots-granny-house)
  (:requirements :typing :fluents :durative-actions :universal-preconditions :conditional-effects :negative-preconditions :continuous-effects)

  (:types
    room corridor - location
    door robot util gripper human
  )

  (:predicates
    (robot_at ?r - robot ?l - location)
    (object_at ?u - util ?l - location)
    (human_at ?r - human ?l - location)
    (gripper_free ?g - gripper)
    (gripper_at ?g - gripper ?r - robot)
    (robot_carry ?r - robot ?g - gripper ?u - util)
    (connected ?l1 ?l2)
    (connected_by_door ?l1 ?l2 - location ?d - door)
    (open ?d - door)
    (close ?d - door)
  )

  (:functions
    (time)
    (cost)
    (priority ?u - util)
  )

  (:durative-action open-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?l1))
      (at start(close ?d))
      (at start(connected_by_door ?l1 ?l2 ?d))
    )
    :effect (and
      (at start(open ?d))
      (at end(not (close ?d)))
    )
  )

  (:durative-action move
    :parameters (?r - robot ?from ?to - location ?d - door)
    :duration (= ?duration 2)
    :condition (and
      (at start(robot_at ?r ?from))
      (or
      (and (at start(connected_by_door ?from ?to ?d)) (at start (open ?d))) 
      (at start(connected ?from ?to)))
  
    )
    :effect (and
      (at end(increase (time) 1))
      (at start(not (robot_at ?r ?from)))
      (at end(robot_at ?r ?to))
    )
  )

  (:durative-action pick
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration(= ?duration 1)
    :condition (and
      (at start(gripper_at ?g ?r))
      (at start(object_at ?u ?l))
      (at start(robot_at ?r ?l))
      (at start(gripper_free ?g))
    )
    :effect (and
      ;importantisimo indicar que el gancho deja de estar libre cuand empieza la accion
      (at start(not (gripper_free ?g)))
      (at end(not (object_at ?u ?l)))
      (at end(robot_carry ?r ?g ?u))
      (at end(increase (time) 1))
    )
  )
  (:durative-action drop
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration(= ?duration 1)
    :condition (and
      (at start(gripper_at ?g ?r))
      (at start(robot_at ?r ?l))
      (at start(robot_carry ?r ?g ?u))
    )
    :effect (and
      (at end(gripper_free ?g))
      (at end(object_at ?u ?l))
      (at end(not (robot_carry ?r ?g ?u)))
      (at end(increase (cost) (* (priority ?u) (time))))
    )
  )
)
