#!/usr/bin/env perl

use strictures;
use File::Slurp;
use GD;
use Image::ExifTool;

do {
    my $im = GD::Image->new('test.jpg') or die "$! $@";
    write_file( 'test-gd.jpg', $im->jpeg ) or die "$! $@";
    my ( $w, $h ) = ( $im->width, $im->height );
    my $im2 = GD::Image->new( $w * .25, $h * .25 ) or die "$! $@";
    $im2->copyResized( $im, 0, 0, 0, 0, $w * .25, $h * .25, $w, $h );

    # write_file( 'test-gd.jpg', $im2->jpeg ) or die "$! $@";
    my $jpg = $im2->jpeg( 80 );

    unlink 'test-gd.jpg';
    my $exif_tool = Image::ExifTool->new;
    $exif_tool->SetNewValuesFromFile('test.jpg') or die;
    # sleep 20;
    $exif_tool->WriteInfo( \$jpg, 'test-gd.jpg' )
      or die $exif_tool->GetValue('Error');
};

# sleep 20;
