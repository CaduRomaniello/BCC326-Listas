function lista05
  
  pkg load image;
  pkg load statistics;
  pkg load nan;
  
  dados = zeros(7000, 7);
  etiquetas = zeros(7000, 1);
  
  extensao = 'jpg';
  path = 'D:\Facul\PDI\listas\lista05\numbers';
  imagens = dir(fullfile(path, ['*.' extensao]));
  qntd_imagens = length(imagens);
  
  disp("\nQuestoes 1, 2, 3 e 4\n");
  pos = 1;
  for i = 1:qntd_imagens
    img = imread(fullfile(path, imagens(i, 1).name));
    
    for rotacao = 0:10:190
      
      for escala = 0.5:0.25:2
        for ruido = 0:0.01:0.04
          
          #disp("\nQuestao 1\n");
          nimg = imrotate(img, rotacao);
          
          #disp("Questao 2\n");
          nimg = imresize(nimg, escala);
          
          #disp("Questao 3\n");
          nimg = imnoise(nimg, "salt & pepper", ruido);
          
          #disp("Questao 4\n");
          v = humoments(nimg);
          
          dados(pos, :) = v;
          
          etiquetas(pos, :) = i - 1;
          pos = pos + 1;
          
        end
      end
    end
  end
  
  disp("\nQuestao 5\n");
  [train, test] = amostra(etiquetas, 0.75);
  
  disp("Questao 6\n");
  train_data = dados(train, :);
  train_label = etiquetas(train);
  
  test_data = dados(test, :);
  test_label = etiquetas(test);
  
  # Na linha 66 estava ocorrendo um erro:
  #   error: 'cl' undefined near line 294, column 294
  #   error: called from
  #     test_sc at line 294 column 14
  #     lista05 at line 66 column 8

  # nao consegui achar um meio para resolve-lo
  # por isso nao fui capaz de fazer os outros exercicios
  model = train_sc(train_data, train_label);
  pred = test_sc(model, test_data);
  
end