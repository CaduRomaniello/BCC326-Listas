# Carlos Eduardo Gonzaga Romaniello de Souza - 19.1.4003

function lista2
  
  lenna = imread("lenna.png");
  lennaRGB = imread("lennaRGB.tif");
  
  #exercicio 1
  disp("--- Exercicio 1 ---");
  disp("  -> a f�rmula foi aplicada recursivamente na imagem o que fez com que a imagem ficasse toda preta.\n");
  function [returnValue] = exercicio_1(img, iter_max)
    newImg = img;
    
    for i = 1:iter_max
    
      R = newImg(:,:,1);
      G = newImg(:,:,2);
      B = newImg(:,:,3);
      
      R = 0.299*R;
      G = 0.587*G;
      B = 0.114*B;
      
      newImg = uint8(cat(3,R,G,B));
    endfor
    
    [returnValue] = newImg;
    
  endfunction
  
  newImg = exercicio_1(lennaRGB, 5);
  imshow(newImg);
  pause(1);
  
  #exercicio 2
  disp("\n--- Exercicio 2 ---");
  disp("  -> nesse exerc�cio foi utilizado o c�digo disponibilziado pelo professor para a rota��o e para as demais transforma��es o slide da aula foi utilizado de base.\n");
  
  function nimg = minhaRotacao(img, ang)
    
    [lin, col, ~] = size(img);
    nimg = zeros(lin, col);
    matT1 = [1 0 -lin/2; 0 1 -col/2; 0 0 1];
    matR = [sind(ang) -cosd(ang) 0; cosd(ang) sind(ang) 0; ...
           0 0 1];
    matT2 = [1 0 lin/2; 0 1 col/2; 0 0 1];
    maT = matT2 * matR * matT1;
    for i = 1 : lin
        for j = 1 : col
            ncoord = maT * [i; j; 1];
            ni = floor(ncoord(1));
            nj = floor(ncoord(2));
            if ni > 0 && ni <= lin && nj > 0 && nj <= col
                nimg(ni, nj) = img(i,j);
            end
        end
    end
    nimg = uint8(nimg);
  endfunction
  
  function returnValue = escalonamento(img, x, y)
    
    [rows, columns, ~] = size(img);
    newImg = zeros(rows, columns);
    matAumento = [x 0 0;0 y 0;0 0 1];
    
    for i = 1:rows
      for j = 1:columns
        newCoord = matAumento * [i; j; 1];
        
        newRow = floor(newCoord(1));
        newColumn = floor(newCoord(2));
        
        if newRow > 0 && newRow <= rows && newColumn > 0 && newColumn <= columns
          newImg(newRow, newColumn) = img(i, j);
        endif
      endfor
    endfor
    
    returnValue = uint8(newImg);
    
  endfunction
  
  function returnValue = translacao(img, x, y)
    
    [rows, columns, ~] = size(img);
    newImg = zeros(rows, columns);
    matTranslacao = [1 0 x;0 1 y;0 0 1];
    
    for i = 1:rows
      for j = 1:columns
        newCoord = matTranslacao * [i; j; 1];
        
        newRow = floor(newCoord(1));
        newColumn = floor(newCoord(2));
        
        if newRow > 0 && newRow <= rows && newColumn > 0 && newColumn <= columns
          newImg(newRow, newColumn) = img(i, j);
        endif
      endfor
    endfor
    
    returnValue = uint8(newImg);
  endfunction
  
  function returnValue = cisalhamento(img, sh)
   
    [rows, columns, ~] = size(img);
    newImg = zeros(rows, columns);
    matCisalhamento = [1 sh 0;0 1 0;0 0 1];
    
    for i = 1:rows
      for j = 1:columns
        newCoord = matCisalhamento * [i; j; 1];
        
        newRow = floor(newCoord(1));
        newColumn = floor(newCoord(2));
        
        if newRow > 0 && newRow <= rows && newColumn > 0 && newColumn <= columns
          newImg(newRow, newColumn) = img(i, j);
        endif
      endfor
    endfor
    
    returnValue = uint8(newImg);
  endfunction
  
  disp("  -> Rotacao");
  x = minhaRotacao(lenna, 45);
  imshow(x);
  pause(1);
  
  disp("  -> Escalonamento");
  x = escalonamento(lenna, 1.5, 1.5);
  imshow(x);
  pause(1);
  
  disp("  -> Translacao");
  x = translacao(lenna, 50, 50);
  imshow(x);
  pause(1);
  
  disp("  -> Cisalhamento");
  x = cisalhamento(lenna, 0.5);
  imshow(x);
  pause(1);
  
  #exercicio 3
  disp("\n--- Exercicio 3 ---");
  disp("  -> nesse exerc�cio as mudan�as na imagem foram feitas manualmente atrav�s das duas fun��es desenvolvidas abaixo.\n");
  
  disp("  Tamanho da imagem original: ");
  disp(size(lenna));
  
  function returnValue = halfImage(img)
   
    [rows, columns, ~] = size(img);
    newImg = zeros(floor(rows/2), floor(columns/2));
    
    rowCount = 1;
    columnCount = 1;
    for i = 1:2:rows
      columnCount = 1;
      for j = 1:2:columns
        average = floor(mean(mean(img(i:i+1, j:j+1), 1), 2));
        newImg(rowCount, columnCount) = average;
        
        columnCount = columnCount + 1;
      endfor
      rowCount = rowCount + 1;
    endfor
    
    returnValue = uint8(newImg);
  endfunction
  
  function returnValue = doubleImage(img)
   
    [rows, columns, ~] = size(img);
    newImg = zeros(rows*2, columns*2);
    
    rowCount = 1;
    columnCount = 1;
    for i = 1:rows
      columnCount = 1;
        for j = 1:columns
        newImg(rowCount, columnCount) = img(i, j);
        newImg(rowCount, columnCount+1) = img(i, j);
        newImg(rowCount+1, columnCount) = img(i, j);
        newImg(rowCount+1, columnCount+1) = img(i, j);
        
        columnCount = columnCount + 2;
      endfor
      rowCount = rowCount + 2;
    endfor
    
    returnValue = uint8(newImg);
  endfunction
  
  disp("  Tamanho ap�s redu��o: ");
  x = halfImage(lenna);
  imshow(x);
  disp(size(x));
  pause(1);
  
  disp("  Tamanho ap�s aumento: ");
  y = doubleImage(x);
  imshow(y);
  disp(size(y));
  pause(1);
  
  #exercicio 4
  disp("\n--- Exercicio 4 ---");
  disp("  -> nesse exerc�cio foram utilizadas as fun��es requisitadas pelo professor. vale ressaltar que para a sess�o referente a fun��o 'rgb2ind', a fun�ao para salvar a imagem resultante crashava o OCTAVE e por isso ela est� comentada no c�digo. Outro detalhe � que para a fun��o im2bw � necess�rio carergar um pacote, para isso basta executar o comando 'pkg load image'.\n");
  
  x = rgb2gray(lennaRGB);
  imwrite(x, 'lenna_rgb2gray.png');
  imshow(x);
  disp("  -> rgb2gray");
  pause(1);
  
  [x, map] = rgb2ind(lennaRGB);
  #imwrite(x, map, 'lenna_rgb2ind.png');
  imshow(x, map);
  disp("  -> rgb2ind");
  pause(1);
  
  x = im2double(lennaRGB);
  imwrite(x, 'lenna_im2double.png');
  imshow(x);
  disp("  -> im2double");
  pause(1);
  
  x = im2bw(lennaRGB, "moments");
  imwrite(x, 'lenna_im2bw.png');
  imshow(x);
  disp("  -> im2bw");
  pause(1);
  
  #exercicio 5
  disp("\n--- Exercicio 5 ---");
  disp("  -> nesse exerc�cio a imagem original foi printada com a ordem das colunas invertidas e logo ap�s a imagem resultante foi printada com as linhas invertidas.\n");
  
  [rows, columns, ~] = size(lennaRGB);
  
  disp("  -> left to right");
  left_right = lennaRGB(:, columns:-1:1, :);
  imshow(left_right);
  pause(1);
  
  disp("  -> up to down");
  up_down = left_right(rows:-1:1, :, :);
  imshow(up_down);
  pause(1);
  
endfunction

















