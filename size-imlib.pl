#!/usr/bin/env perl

use strictures;
use Image::Imlib2;
use Image::ExifTool;

do {

    my $im = Image::Imlib2->load('test.jpg') or die;
    my ( $w, $h ) = ( $im->width, $im->height );

    my $im2 = $im->create_scaled_image( $w * .25, $h * .25 ) or die;
    $im2->set_quality(80);

    $im2->image_set_format( 'jpeg' );
    $im2->save('test-imlib.jpg') and die;

    my $exif_tool = Image::ExifTool->new;
    $exif_tool->SetNewValuesFromFile('test.jpg') or die;
    $exif_tool->WriteInfo( 'test-imager.jpg' )
      or die $exif_tool->GetValue('Error');
};

sleep 20 if @ARGV>= 1 && $ARGV[0] eq 'wait';
