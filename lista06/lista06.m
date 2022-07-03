function lista06
  
  pkg load image;
  img = imread("coins.png");
  lenna = imread("lenna_gray.png");
  
  display("\nQuestao 1\n");
  display("  Sobel\n"); imshow(edge(lenna, "Sobel")); pause(1);  
  display("  Prewitt\n"); imshow(edge(lenna, "Prewitt")); pause(1); 
  display("  Roberts\n"); imshow(edge(lenna, "Roberts")); pause(1); 
  display("  Canny\n"); imshow(edge(lenna, "Canny")); pause(1); 
  display("  loG\n"); imshow(edge(lenna, "loG")); pause(1);
  display("  zerocross\n"); imshow(edge(lenna, "zerocross", graythresh(lenna), fspecial("log")));   
  # A mascara Canny apresentou melhor resultado
  
  
  display("\nQuestao 2\n");
  T  = globalT(0.25, lenna);
  fprintf("-> T = %d\n", T);
  imshow(im2bw(lenna, T)); pause(1);
    
  function T = globalT(n, img)
      [rows, cols] = size(img);
      nimg = im2double(img);
      G1  = [];
      G2  = [];
      T_antigo = 0;
        
      T = mean(nimg(:));
        
      do
        T_antigo = T;
          
        for i = 1:rows
          for j = 1:cols
            if (nimg(i,j) > T) 
              G1(end+1) = nimg(i,j);
            else
              G2(end+1) = nimg(i,j);
            endif
          endfor
        endfor
        
        mi_1 = mean(G1);
        mi_2 = mean(G2);
        T = (mi_1+mi_2) / 2;
      until (abs(T - T_antigo) < n)
    end
  
  
  display("\nQuestao 3\n");
  display("  Nao consegui resolver a questao\n");
  
  # Nao consegui resolver essa questtao
  
  coins = degrade();
  display("  Original\n");
  imshow(coins);
    
  function nimg = degrade()
      [row, col, ~] = size(img);
      [x, y] = meshgrid(1:row, 1:col);
      t2 = double(img) .* ((x + y) / 2 + 64) + x + y ;
      nimg = uint8(255 * mat2gray(t2));
  end
  
  display("\nQuestao 4\n");
  nimg = degrade();
  display("  Original\n");
  imshow(nimg);
  pause(1);
  display("  Otsu\n");
  imshow(im2bw(nimg, graythresh(nimg)));
  pause(1);
  
end