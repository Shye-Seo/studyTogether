const quotes=[
    {
        quote:"What do you want a meaning for? Life is a desire, not a meaning.",
        author:"Charlie Chaplin",
    },{
        quote:"When you jump for joy, beware that no one moves the ground from beneath your feet.",
        author:"Stanislaw J. Lec",
    },{
        quote:"It is wise to apply the oil of refined politeness to the mechanisms of friendship.",
        author:"Colette",
    },{
        quote:"A penny saved is a penny earned.",
        author:"Benjamin Franklin",
    },{
        quote:"Mistakes are the portals of discovery.",
        author:"James Joyce",
    },{
        quote:"By perseverance the snail reached the ark.",
        author:"Charles Haddon Spurgeon",
    },{
        quote:"If I had to live my life again, I'd make the same mistakes, only sooner.",
        author:"Tallulah Bankhead",
    },{
        quote:"The greatest virtues are those which are most useful to other persons.",
        author:"Aristotle",
    },{
        quote:"No passion so effectually robs the mind of all its powers of acting and reasoning as fear.",
        author:"Edmund Burke",
    },{
        quote:"Force without wisdom falls of its own weight.",
        author:"Horace"
    }
];

const quote = document.querySelector("#quote h3");
const author = document.querySelector("#quote h4");

function requote(){
    const todaysQuote = quotes[Math.floor(Math.random()*quotes.length-1)];
    
    quote.innerText = todaysQuote.quote;
    author.innerText = todaysQuote.author;
};
requote();
setInterval(requote,5000);