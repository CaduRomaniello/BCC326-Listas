function lista04
  
  pkg load image;
  
  matches = imread("matches.png");
  matchMask = imread("matchMask.png");
  
  disp("\nQuestao 1");
  function [nimg, figs] = NoiseSum (img, n)
    [lin, col, ~] = size(img);
    nimg = zeros(size(img)) ;
    figs = zeros(lin, col, n);
    for i = 1:n
      figs(:,:,i) = imnoise(img, 'salt & pepper') ;
    end
    figs = sort(figs, 3);
    [x, y, z] = size(figs);
    
    nimg = uint8(figs(:,:,floor(z/2)));
  end

   disp("Calculando...\n");
  [nimg, figs] = NoiseSum(matches, 31);
  
  imshow(nimg);
  disp("Mostrando resultado!\n");
  pause(2);
  
  
  disp("\n\nQuestao 2");
  function [nimg] = questao2 (img, mask, inc)
    [lin, col, ~] = size(mask);
    aux = zeros(lin, col, 3);
    r = zeros(lin, col);
    g = zeros(lin, col);
    g = zeros(lin, col);
    
    for i = 1:lin
      for j = 1:col
        if (mask(i, j) == 0)
          r(i, j) = img(i, j) + inc;
          g(i, j) = img(i, j) + inc;
          b(i, j) = img(i, j) + (2 * inc);
         else
          r(i, j) = img(i, j);
          g(i, j) = img(i, j);
          b(i, j) = img(i, j);
        end
      end
    end
    aux = cat(3, r, g, b);
    nimg = uint8(aux);
  end
  
  disp("Calculando...\n");
  x = questao2(matches, matchMask, 50);
  imshow(x);
  disp("Mostrando resultado!\n");
  
  
end