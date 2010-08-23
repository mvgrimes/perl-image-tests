#!/usr/bin/env perl

use strictures;
use Imager;
use Image::ExifTool;

do {
    my $im = Imager->new;
    $im->read( file => 'test.jpg' ) or die;
    my ( $w, $h ) = ( $im->getwidth, $im->getheight );
    my $im2 = $im->scale( scalefactor => .25 ) or die;

    # This should work, but Imager doesn't write the tag data 
    # for ( $im->tags ) {
    #     printf "%30s: %s\n", @$_;
    #     $im2->settag( name => $_->[0], value => $_->[1] ) or die;
    # }
    # $im2->write( file => 'test-imager.jpg', jpegquality => 80 ) or die;

    my $jpg;
    $im2->write( data => \$jpg, type=>'jpeg' ) or die $im2->errstr;

    unlink 'test-imager.jpg';
    my $exif_tool = Image::ExifTool->new;
    $exif_tool->SetNewValuesFromFile('test.jpg') or die;
    $exif_tool->WriteInfo( \$jpg, 'test-imager.jpg' )
      or die $exif_tool->GetValue('Error');
    
};

sleep 20 if @ARGV>= 1 && $ARGV[0] eq 'wait';
