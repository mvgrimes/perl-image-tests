#!/usr/bin/env perl

use strictures;
use Imager;

my $img = Imager->new;
$img->read( file => 'test.jpg' ) or die;
$img->box(
    color  => Imager::Color->new( 0, 0, 255 ),
    xmin   => 10,
    ymin   => 10,
    xmax   => 90,
    ymax   => 90,
    filled => 1
) or die $img->errstr;
print "Src exif_model: ", $img->tags( name => 'exif_model' ), "\n";

$img->settag( name => 'exif_model', value => 'Homemade' ) or die;
my $jpg;
$img->write( data => \$jpg, type => 'jpeg' ) or die $img->errstr;
print "Orig after write: ", $img->tags( name=>'exif_model'), "\n";

my $im2 = Imager->new;
$im2->read( data => $jpg ) or die $im2->errstr;
print "Read: ", $im2->tags( name => 'exif_model' ), "\n";

