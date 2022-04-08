#include <SFML/Graphics.hpp>

int main()
{
    sf::RenderWindow window(sf::VideoMode(800, 600), "Game",sf::Style::Close);
    window.setFramerateLimit(60);

    sf::Texture texture;
    if (!texture.loadFromFile("bin/image/1.png"))
    {
        // error...
    }
    sf::Sprite sprite;
    sprite.setTexture(texture);

    sprite.scale(0.2f, 0.2f);

    sf::Texture fonT;
    if (!fonT.loadFromFile("bin/image/fon.jpg"))
    {
        // error...
    }

    sf::Sprite fon;
    fon.setTexture(fonT);
    
    
    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                window.close();
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
        {
            sf::FloatRect r = sprite.getGlobalBounds();
            if(r.left>0){
                sprite.move(sf::Vector2f(-4.f, 0.f));
            }
            
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
        {
            sprite.move(sf::Vector2f(4.f, 0.f));
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
        {
            sprite.move(sf::Vector2f(0.f, 4.f));
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
        {
            sf::FloatRect r = sprite.getGlobalBounds();
            if(r.top>400.0){
                sprite.move(sf::Vector2f(0.f, -4.f));
            }

            
        }


        window.clear();
        window.draw(fon);
        window.draw(sprite);

        window.display();
    }

    return 0;
}