add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";
sub makeglossaries {
  my ($name, $path) = fileparse( $$Psource );
  if ( $silent ) {
    return system "makeglossaries -d '$path' '$name'";
  } else {
    return system "makeglossaries -q -d '$path' '$name'";
  };
}

add_cus_dep( 'svg', 'pdf', 0, 'svg2pdf' );
sub svg2pdf {
  system("rsvg-convert -f pdf -o $_[0].pdf $_[0].svg");
}

add_cus_dep( 'ipe', 'pdf', 0, 'ipe2pdf' );
sub ipe2pdf {
  system("ipetoipe -pdf -export $_[0].ipe $_[0].pdf");
}
