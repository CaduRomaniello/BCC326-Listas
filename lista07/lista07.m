function lista07
  
  pkg load image;
  
  # Questão 1
  disp("\nQuestao 1\n");
  img = imread('num0.jpg');
  
  x = rand(size(img));
  d1 = find(x <= 0.05);
  d2 = find(x >= 0.95);
  img(d1) = 0;
  img(d2) = 1;
  
  sp = ones(3) ;
  sk = [ 0 1 0 ; 1 1 1 ; 0 1 0 ] ;
 
  imshow(img);
  disp("  Imagem ruidosa.");
  pause(2);
  
  # Teste 1
  nimg = imerode(img, sp);
  nimg = imdilate(nimg, sp);
  
  nimg = imdilate(nimg, sp);
  nimg = imerode(nimg, sp);
  
  imshow(nimg);
  disp("  Primeiro teste");
  pause(2);
  
  # Teste 2
  nimg = imerode(img, sk);
  nimg = imdilate(nimg, sk);
  
  nimg = imdilate(nimg, sk);
  nimg = imerode(nimg, sk);
  
  imshow(nimg);
  disp("  Segundo teste");
  pause(2);
  
  # Questão 2
  #  nao consegui fazer essa questao
  disp("\nQuestao 2\n");
  disp("Não consegui fazer essa questão. O funcionamento da função estava incorreto.\n");
  
  # Questão 3
  disp("\nQuestao 3\n");
  img = imread('num0.jpg');
  
  # Letra a
  nimg = img - imerode(img, sk);
  
  imshow(nimg);
  disp("  letra a\n");
  pause(2);
  
  # Letra b
  nimg = imdilate(img, sk) - img;
  
  imshow(nimg);
  disp("  letra b\n");
  pause(2);
  
  # Letra c
  nimg = imdilate(img, sk) - imerode(img, sk);
  
  imshow(nimg);
  disp("  letra c\n");
  pause(2);
  
end