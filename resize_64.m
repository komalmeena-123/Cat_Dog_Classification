function resized_img = resize_64(img)
  coder.extrinsic('imresize','imwrite');
  resized_img = imresize(img,[64 64]);
end

