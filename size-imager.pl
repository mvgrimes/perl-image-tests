#!/usr/bin/env perl

use strictures;
use Imager;

do {

    my $im = Imager->new;
    $im->read( file => 'test.jpg' ) or die;
    my ( $w, $h ) = ( $im->getwidth, $im->getheight );
    my $im2 = $im->scale( scalefactor => .25 ) or die;

    for ( $im->tags ) {
        $im2->addtag( name => $_->[0], value => $_->[1] ) or die;
    }

    # sleep 20;
    $im2->write( file => 'test-imager.jpg', jpegquality => 80 ) or die;
};

# sleep 20;
