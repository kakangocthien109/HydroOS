/* === This file is part of Calamares - <http://github.com/calamares> ===
 *
 *   Copyright 2015, Teo Mrnjavac <teo@kde.org>
 *
 *   Calamares is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Calamares is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Calamares. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 5000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {

        Image {
            id: background1
            source: "hydro.png"
            width: 800; height: 350
            fillMode: Image.PreserveAspectFit
			      anchors.centerIn: parent
        }

    }


    Slide {

        Image {
            id: background3
            source: "hydro2.png"
            width: 800; height: 350
            fillMode: Image.PreserveAspectFit
			anchors.centerIn: parent
        }
}


function onActivate() {
          console.log("QML Component (default slideshow) activated");
          presentation.currentSlide = 0;
    }

    function onLeave() {
          console.log("QML Component (default slideshow) deactivated");
    }

}
