-------------------------- MODULE FarmerGooseFox  --------------------------

VARIABLES 
  farmer,
  beans,
  goose,
  fox

vars == { farmer, beans, goose, fox }

TypeOK == \A a \in vars : a \in BOOLEAN 

Init == /\ farmer = FALSE
        /\ beans = FALSE
        /\ goose = FALSE
        /\ fox = FALSE

Final == \A a \in vars : a

CrossesAlone == /\ (farmer' = ~ farmer) 
                /\ UNCHANGED << beans, goose, fox >>       

CrossesWithbeans ==  (farmer = beans)
                    /\ (farmer' = ~ farmer) 
                    /\ (beans' = ~ beans) 
                    /\ UNCHANGED << goose, fox >>      

CrossesWithgoose == (farmer = goose)
                   /\ (farmer' = ~ farmer) 
                   /\ (goose' = ~ goose) 
                   /\ UNCHANGED << beans, fox >>      

CrossesWithfox ==  (farmer = fox)
                   /\ (farmer' = ~ farmer) 
                   /\ (fox' = ~ fox) 
                   /\ UNCHANGED << beans, goose >>                                                      

Safe == (goose = farmer)
        \/ ( goose # fox /\ goose # beans )        

Next == /\ \/ CrossesAlone
           \/ CrossesWithbeans
           \/ CrossesWithgoose
           \/ CrossesWithfox
        /\ Safe'

\* Unsolved == ~ Final

=============================================================================
\* based on yuriy's version