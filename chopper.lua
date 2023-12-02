 1. --[[um programa que corta arvores dentro do minecraft usando lua.]]
 3.
 4. if not turtle.detect() then
 5.   error('Não encontrei um árvore!')
 6. end
 7.
 8. print('Cortando árvore...')
 9.
10. if not turtle.dig() then  -- corta a base da árvore
11.   error('Turtle precisa de uma ferramenta para cortar!')
12. end
13.
14. turtle.forward()  -- se move para baixo da árvore
15. while turtle.compareUp() do
16.   -- continua cortando até que não tenha mais árvore
17.   turtle.digUp()
18.   turtle.up()  
19. end
20.
21. -- Volta para o inicio no chão
22. while not turtle.detectDown() do
23.   turtle.down()
24. end
25.
26. print('Árvore cortada, fim!.')
