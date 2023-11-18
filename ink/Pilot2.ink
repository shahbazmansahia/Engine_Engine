VAR test = false
VAR choice1 = true
VAR choice2 = false
VAR choice3 = false
VAR choice4 = false
VAR choice5 = false
It seems that we are trapped here..

-> main

=== main ===
 * [What should we do?] -> what_should_we_do
 * [Tell me what happened again] -> what_happened_again
 * [Ask about the strange sounds] ->strange_sounds
 * [We are not alone] -> not_alone
 * [I need to go now] -> end
 
    
=== what_should_we_do ===

Surivial isn't part of our training. Damn! How did this happen. And we still need to continue the mission. We spent too much time and resources already. Let's focus on finding shelter before nightfall
->main

=== what_happened_again ===

The ship crashed on arrival. 
-> main

=== strange_sounds ===
Strange sounds? I haven't heard anything like that. 
-> main

=== not_alone ===
Grab your rifle, we need to defend ourselves.
-> main

=== end ===
Ok
    -> END